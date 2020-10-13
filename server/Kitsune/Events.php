<?php

namespace Kitsune;

final class Events {

	/* Values are callables
	Keys are event names
	*/
	private static $events = array();

	/* Values are arrays
	Arrays consist of three elements:
	Callable, interval, and the last time it was called
	*/
	private static $timedEvents = array();

	public static function GetTimedEvents() {
		return self::$timedEvents;
	}

	public static function GetEvents() {
		return self::$events;
	}

	public static function GetEvent($event) {
		if(array_key_exists($event, self::$events)) {
			return self::$events[$event];
		}
	}

	public static function ResetInterval($eventIndex) {
		if(array_key_exists($eventIndex, self::$timedEvents)) {
			self::$timedEvents[$eventIndex][2] = time();
		}
	}

	public static function RemoveInterval($eventIndex) {
		if(array_key_exists($eventIndex, self::$timedEvents)) {
			unset(self::$timedEvents[$eventIndex]);

			return true;
		} else {
			return false;
		}
	}

	// Interval in seconds
	public static function AppendInterval($interval, $callable) {
		$eventArray = [$callable, $interval, null];
		array_push(self::$timedEvents, $eventArray);

		$eventIndex = array_search($eventArray, self::$timedEvents);
		return $eventIndex;
	}

	// Adds event and/or event callable
	public static function Append($event, $callable) {
		if(array_key_exists($event, self::$events)) {
			array_push(self::$events, $callable);
		} else {
			self::$events[$event] = array($callable);
		}

		$callableIndex = array_search($callable, self::$events);

		return $callableIndex;
	}

	// Removes event, or event callable (by index)
	public static function Remove($event, $callableIndex = null) {
		if(array_key_exists($event, self::$events)) {
			if($callableIndex === null) {
				unset(self::$events[$event]);
			} else {
				if(array_key_exists($callableIndex, self::$events[$event])){
					unset(self::$events[$event][$callableIndex]);
				} else {
					return false;
				}
			}

			return true;
		} else {
			return false;
		}
	}

	public static function Fire($event, $data = null) {
		if(array_key_exists($event, self::$events)) {
			foreach(self::$events[$event] as $eventCallable) {
				call_user_func($eventCallable, $data);
			}
		}
	}

	// Clears the entire event array
	public static function Flush($event) {
		if(array_key_exists($event, self::$events)) {
			self::$events[$event] = array();
		}
	}

}

?>