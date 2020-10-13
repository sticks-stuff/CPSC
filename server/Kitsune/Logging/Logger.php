<?php

namespace Kitsune\Logging;

class Logger implements ILogger {

	public static $logOnly = array();
	public static $noOutput = array();
	public static $logToFile = true;
	public static $logToSentry = true;
	// public static $sentryClient = new Raven_Client('https://92b7b33e760744bfacc1c41324b4f823:7d378081473942e48d08f9eb071efc43@sentry.io/188157');
	//
	// private static function LogToSentry($data, $logLevel) {
	// 	$sentryClient->captureMessage($data, array(
  //   	'logger' => $logLevel,
	// 	));
	// }

	private static function LogToFile($writeData, $logLevel) {
		$logsDirectory = sprintf("%s/Logs/", __DIR__);

		if(!is_dir($logsDirectory)) mkdir($logsDirectory);

		$logFile = fopen(sprintf("%s%s.txt", $logsDirectory, $logLevel), "a");
		fwrite($logFile, sprintf("%s", $writeData));
		fclose($logFile);
	}

	private static function Log($message, $logLevel) {
		if(!empty(self::$logOnly) && !in_array($logLevel, self::$logOnly)) return;

		if(!in_array($logLevel, self::$noOutput)) {
			$writeData = sprintf("%s [%s] > %s%c", date(self::DateFormat), $logLevel, $message, 10);
			echo $writeData;
		}

		if(self::$logToFile) {
			self::LogToFile($writeData, $logLevel);
		}

		// switch ($logLevel) {
    // 	case self::Info:
		// 			self::LogToSentry($writeData, "info");
    //     	break;
    // 	case self::Warn:
		// 			self::LogToSentry($writeData, "warning");
    //     	break;
    // 	case self::Error:
		// 			self::LogToSentry($writeData, "error");
    //     	break;
		// 	case self::Fatal:
		// 			self::LogToSentry($writeData, "fatal");
		//       break;
    // 	default:
		// 			self::LogToSentry($writeData, "default");
		// 	}
	}

	public static function Info($message) {
		self::Log($message, self::Info);
	}

	public static function Fine($message) {
		self::Log($message, self::Fine);
	}

	public static function Notice($message) {
		self::Log($message, self::Notice);
	}

	public static function Debug($message) {
		self::Log($message, self::Debug);
	}

	public static function Warn($message) {
		self::Log($message, self::Warn);
	}

	public static function Error($message) {
		self::Log($message, self::Error);
	}

	public static function Fatal($message) {
		self::Log($message, self::Fatal);
		die();
	}

}

?>
