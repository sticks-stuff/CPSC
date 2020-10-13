<?php

namespace Kitsune\ClubPenguin;

use Kitsune;
use Kitsune\Logging\Logger;
use Kitsune\DatabaseManager;
use Kitsune\ClubPenguin\Packets\Packet;
use Kitsune\ClubPenguin\Plugins\Base\IPlugin as Plugin;

abstract class ClubPenguin extends Kitsune\Kitsune {

	private $xmlHandlers = array(
		"policy" => "handlePolicyRequest",
		"verChk" => "handleVersionCheck",
		"rndK" => "handleRandomKey",
		"login" => "handleLogin"
	);

	protected $worldHandlers = array(
		// Overridden in the World class
	);

	public $databaseManager;

	public $loadedPlugins = array();

	public $discord;

	protected function __construct($loadPlugins = true, $pluginsDirectory = "Kitsune/ClubPenguin/Plugins/") {
		$tempDatabase = new Kitsune\Database();
		unset($tempDatabase);

		$this->databaseManager = new DatabaseManager();

		if($loadPlugins === true) {
			$this->loadPlugins($pluginsDirectory);
		}

		// $errorHandler = new Raven_ErrorHandler(Logger::$sentryClient);
		// $errorHandler->registerExceptionHandler();
		// $errorHandler->registerErrorHandler();
		// $errorHandler->registerShutdownFunction();
	}

	public function checkPluginDependencies() {
		foreach($this->loadedPlugins as $pluginClass => $pluginObject) {
			if(!empty($pluginObject->dependencies)) {
				foreach($pluginObject->dependencies as $dependencyKey => $dependencyValue) {
					if(!isset($this->loadedPlugins[$dependencyKey]) && !isset($this->loadedPlugins[$dependencyValue])) {
						$pluginDependency = is_numeric($dependencyKey) ? $dependencyValue : $dependencyKey;

						Logger::Warn("Dependency '$pluginDependency' for plugin '$pluginClass' not loaded!");
						unset($this->loadedPlugins[$pluginClass]);
					}
				}
			}
		}
	}

	public function loadPlugin($pluginClass, $pluginNamespace) {
		$pluginPath = sprintf("%s\%s", $pluginNamespace, $pluginClass);

		$pluginObject = new $pluginPath($this);
		$this->loadedPlugins[$pluginClass] = $pluginObject;

		$removePlugin = false;

		if(empty($this->worldHandlers) && $pluginObject->loginServer !== true) {
			unset($this->loadedPlugins[$pluginClass]);

			unset($pluginObject);

			return false;
		}

		if(!empty($pluginObject->xmlHandlers)) {
			foreach($pluginObject->xmlHandlers as $xmlHandler => $handlerProperties) {
				list($handlerCallback, $callInformation) = $handlerProperties;

				if($callInformation == Plugin::Override) {
					$this->xmlHandlers[$xmlHandler] = array($pluginObject, $handlerCallback);
				}
			}
		}

		if(!empty($pluginObject->worldHandlers)) {
			foreach($pluginObject->worldHandlers as $packetExtension => $extensionHandlers) {
				if($packetExtension != null && $extensionHandlers !== null) {
					foreach($extensionHandlers as $packetHandler => $handlerProperties) {
						list($handlerCallback, $callInformation) = $handlerProperties;

						if($callInformation == Plugin::Override) {
							$this->worldHandlers[$packetExtension][$packetHandler] = array($pluginObject, $handlerCallback);
						}
					}
				}
			}
		}

		foreach($this->loadedPlugins as $loadedPlugin) {
			if(!empty($loadedPlugin->dependencies)) {
				if(isset($loadedPlugin->dependencies[$pluginClass])) {
					$onloadCallback = $loadedPlugin->dependencies[$pluginClass];

					call_user_func(array($loadedPlugin, $onloadCallback));
				}
			}
		}

		$pluginObject->onReady();
	}

	public function loadPluginFolder($pluginFolder) {
		$pluginNamespace = str_replace("/", "\\", $pluginFolder);
		$pluginNamespace = rtrim($pluginNamespace, "\\");

		$pluginFiles = scandir($pluginFolder);
		$pluginFiles = array_splice($pluginFiles, 2);

		// Filter directories using array_map
		$pluginFolders = array_map(
			function($pluginFile) use($pluginFolder) {
				$lePath = sprintf("%s%s", $pluginFolder, $pluginFile);

				if(is_dir($lePath)) {
					return $lePath;
				}
			}, $pluginFiles
		);

		$pluginFiles = array_diff($pluginFiles, $pluginFolders);

		$pluginClasses = array_map(
			function($pluginFile) {
				return basename($pluginFile, ".php");
			}, $pluginFiles
		);

		// Load plugins by class
		foreach($pluginClasses as $pluginClass) {
			if(!isset($this->loadedPlugins[$pluginClass])) {
				if(in_array($pluginClass . ".php", $pluginFiles)) {
					$this->loadPlugin($pluginClass, $pluginNamespace);
				}
			}
		}

		// Load plugin folders
		foreach($pluginFolders as $pluginFolder) {
			if($pluginFolder !== null) {
				$this->loadPluginFolder($pluginFolder);
			}
		}
	}

	public function loadPlugins($pluginsDirectory) {
		if(!is_dir($pluginsDirectory)) {
			Logger::Error("Plugins directory ($pluginsDirectory) does not exist!");
		} else {
			$pluginFolders = scandir($pluginsDirectory);
			$pluginFolders = array_splice($pluginFolders, 2);

			$pluginFolders = array_filter($pluginFolders,
				function($pluginFolder) {
					if($pluginFolder != "Base") {
						return true;
					}
				}
			);

			foreach($pluginFolders as $pluginFolder) {
				$folderPath = sprintf("%s%s", $pluginsDirectory, $pluginFolder);

				$this->loadPluginFolder($folderPath);
			}

			// Check dependencies
			$this->checkPluginDependencies();

			$pluginCount = sizeof($this->loadedPlugins);

			if($pluginCount != 0) {
				Logger::Info(sprintf("Loaded %d plugin(s): %s", $pluginCount, implode(', ', array_keys($this->loadedPlugins))));
			} else {
				Logger::Info("No plugins loaded");
			}
		}
	}

	protected function handlePolicyRequest($socket) {
		$penguin = $this->penguins[$socket];

		if($penguin->handshakeStep === null) {
			$penguin->send("<cross-domain-policy><allow-access-from domain='*' to-ports='{$this->port}' /></cross-domain-policy>");
			$penguin->handshakeStep = "policy";
		} else {
			$this->removePenguin($penguin);
		}
	}

	protected function handleVersionCheck($socket) {
		$penguin = $this->penguins[$socket];

		if(Packet::$Data["body"]["ver"]["@attributes"]["v"] == 153) {
			$penguin->send("<msg t='sys'><body action='apiOK' r='0'></body></msg>");
			$penguin->handshakeStep = "versionCheck";

			return true;
		} else {
			$penguin->send("<msg t='sys'><body action='apiKO' r='0'></body></msg>");
			$this->removePenguin($penguin);

			return false;
		}
	}

	protected function handleRandomKey($socket) {
		$penguin = $this->penguins[$socket];
		Logger::Debug($penguin->username);

		if($penguin->handshakeStep === "versionCheck") {
			$penguin->randomKey = "e4a2dbcca10a7246817a83cd" . $penguin->username; 
			Logger::Debug($penguin->randomKey);
			$penguin->send("<msg t='sys'><body action='rndK' r='-1'><k>" . $penguin->randomKey . "</k></body></msg>");
			$penguin->handshakeStep = "randomKey";

			return true;
		}

		$this->removePenguin($penguin);
	}

	abstract protected function handleLogin($socket);

	protected function handleXmlPacket($socket) {
		if(!isset($this->penguins[$socket])) {
			return $this->removeClient($socket);
		}

		$xmlPacket = Packet::GetInstance();

		$penguin = $this->penguins[$socket];

		foreach($this->loadedPlugins as $loadedPlugin) {
			if($loadedPlugin->loginStalker) {
				$loadedPlugin->handleXmlPacket($penguin);
			} elseif(isset($loadedPlugin->xmlHandlers[$xmlPacket::$Handler])) {
				list($handlerCallback, $callInformation) = $loadedPlugin->xmlHandlers[$xmlPacket::$Handler];

				if($callInformation == Plugin::Before || $callInformation == Plugin::Both) {
					$loadedPlugin->handleXmlPacket($penguin);
				}
			}
		}

		if(isset($this->xmlHandlers[$xmlPacket::$Handler])) {
			$handlerCallback = $this->xmlHandlers[$xmlPacket::$Handler];

			if(is_array($handlerCallback)) {
				call_user_func($handlerCallback, $penguin);
			} elseif(method_exists($this, $handlerCallback)) {
				call_user_func(array($this, $handlerCallback), $socket);
			} else {
				Logger::Warn("Method for {$xmlPacket::$Handler} is un-callable!");
			}
		} else {
			Logger::Warn("Method for {$xmlPacket::$Handler} not found!");
		}

		foreach($this->loadedPlugins as $loadedPlugin) {
			if($loadedPlugin->loginStalker) {
				$loadedPlugin->handleXmlPacket($penguin);
			} elseif(isset($loadedPlugin->xmlHandlers[$xmlPacket::$Handler])) {
				list($handlerCallback, $callInformation) = $loadedPlugin->xmlHandlers[$xmlPacket::$Handler];

				if($callInformation == Plugin::After || $callInformation == Plugin::Both) {
					$loadedPlugin->handleXmlPacket($penguin);
				}
			}
		}
	}

	protected function handleWorldPacket($socket) {

		if(!isset($this->penguins[$socket])) {
			return $this->removeClient($socket); // idk why, but removing this causes shit to go down
		}

		if($this->penguins[$socket]->identified == true || Packet::$Handler == "f#epfgf") {

			// Bot detection - there's probably a better way of doing this
			if ($this->port !== 3119) {
				if(Packet::$Handler !== "f#epfgf") {
					if(Packet::$Handler !== "j#js" && $this->penguins[$socket]->room === null) {
						return $this->removePenguin($this->penguins[$socket]);
					}
				}
			}

			$worldPacket = Packet::GetInstance();

			$penguin = $this->penguins[$socket];

			foreach($this->loadedPlugins as $loadedPlugin) {
				if($loadedPlugin->worldStalker) {
					$loadedPlugin->handleWorldPacket($penguin);
				} elseif(isset($loadedPlugin->worldHandlers[$worldPacket::$Extension][$worldPacket::$Handler])) {
					list($handlerCallback, $callInformation) = $loadedPlugin->worldHandlers[$worldPacket::$Extension][$worldPacket::$Handler];

					if($callInformation == Plugin::Before || $callInformation == Plugin::Both) {
						$loadedPlugin->handleWorldPacket($penguin);
					}
				}
			}

			if(isset($this->worldHandlers[$worldPacket::$Extension])) {
				if(!empty($this->worldHandlers[$worldPacket::$Extension])) {
					if(isset($this->worldHandlers[$worldPacket::$Extension][$worldPacket::$Handler])) {
						$handlerCallback = $this->worldHandlers[$worldPacket::$Extension][$worldPacket::$Handler];

						if(is_array($handlerCallback)) {
							call_user_func($handlerCallback, $penguin);
						} elseif(method_exists($this, $handlerCallback)) {
							call_user_func(array($this, $handlerCallback), $socket);
						} else {
							Logger::Warn("Method for {$worldPacket::$Extension}%{$worldPacket::$Handler} is un-callable!");
						}
					} else {
						Logger::Warn("Method for {$worldPacket::$Extension}%{$worldPacket::$Handler} doesn't exist/has not been set");
					}
				} else {
					Logger::Warn("There are no handlers for {$worldPacket::$Extension}");
				}
			} else {
				Logger::Warn("The packet extension '{$worldPacket::$Extension}' is not handled");
			}

			foreach($this->loadedPlugins as $loadedPlugin) {
				if($loadedPlugin->worldStalker) {
					$loadedPlugin->handleWorldPacket($penguin, false);
				} elseif(isset($loadedPlugin->worldHandlers[$worldPacket::$Extension][$worldPacket::$Handler])) {
					list($handlerCallback, $callInformation) = $loadedPlugin->worldHandlers[$worldPacket::$Extension][$worldPacket::$Handler];

					if($callInformation == Plugin::After || $callInformation == Plugin::Both) {
						$loadedPlugin->handleWorldPacket($penguin, false);
					}
				}
			}
		} else {
			$this->removePenguin($this->penguins[$socket]);
			Logger::Debug("CALLED 4");
		}
	}

}

?>
