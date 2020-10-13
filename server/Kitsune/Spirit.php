<?php

namespace Kitsune;
use Kitsune\Events;
use Kitsune\Logging\Logger;

class BindException extends \Exception {}

abstract class Spirit {

	protected $sockets = array();
	protected $port;
	protected $masterSocket;

	private function accept() {
		$clientSocket = socket_accept($this->masterSocket);
		socket_set_option($clientSocket, SOL_SOCKET, SO_REUSEADDR, 1);
		socket_set_nonblock($clientSocket);
		$this->sockets[] = $clientSocket;

		return $clientSocket;
	}

	protected function handleAccept($socket) {
		echo "Client accepted\n";
	}

	protected function handleDisconnect($socket) {
		echo "Client disconnected\n";
	}

	protected function handleReceive($socket, $data) {
		echo "Received data: $data\n";
	}

	protected function removeClient($socket) {
		Events::Fire("disconnect", $socket);

		$client = array_search($socket, $this->sockets);
		unset($this->sockets[$client]);

		if(is_resource($socket)) {
			socket_close($socket);
		}

		Events::Fire("disconnected", $socket);
	}

	public function listen($address, $port, $backlog = 25, $throwException = false) {
		$socket = socket_create(AF_INET, SOCK_STREAM, SOL_TCP);

		socket_set_option($socket, SOL_SOCKET, SO_REUSEADDR, 1);
		socket_set_nonblock($socket);

		$success = socket_bind($socket, $address, $port);

		if($success === false) {
			if($throwException !== false){
				throw new BindException(
					"Error binding to port $port: " .
					socket_strerror(socket_last_error($socket))
				);
			} else {
				return false;
			}
		}

		socket_listen($socket, $backlog);

		$this->masterSocket = $socket;
		$this->port = $port;
	}

	public function acceptClients() {
		foreach(Events::GetTimedEvents() as $eventIndex => $timedEvent) {
			list($callable, $interval, $lastCall) = $timedEvent;

			if($lastCall === null) {
				Events::ResetInterval($eventIndex);
			} elseif(time() - $interval < $lastCall) {
				continue;
			} else {
				call_user_func($callable, $this);

				Events::ResetInterval($eventIndex);
			}
		}

		$sockets = array_merge(array($this->masterSocket), $this->sockets);
		$changedSockets = socket_select($sockets, $write, $except, 0, 20000);

		if($changedSockets === 0) {
			return false;
		} else {
			if(in_array($this->masterSocket, $sockets)) {
				$clientSocket = $this->accept();
				$this->handleAccept($clientSocket);
				unset($sockets[0]);
			}

			foreach($sockets as $socket) {
				$mixedStatus = socket_recv($socket, $buffer, 8192, 0);
				if($mixedStatus == null) {
					$this->handleDisconnect($socket);
					$this->removeClient($socket);
					continue;
				} else {
					$this->handleReceive($socket, $buffer);
				}
			}
		}
	}

}

ob_implicit_flush();

?>
