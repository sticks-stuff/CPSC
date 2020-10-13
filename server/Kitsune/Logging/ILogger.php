<?php

namespace Kitsune\Logging;

interface ILogger {

	const Info = "Info";
	const Fine = "Fine";
	const Notice = "Notice";
	const Debug = "Debug";
	const Warn = "Warn";
	const Error = "Error";
	const Fatal = "Fatal";
	
	const DateFormat = "H:i:s";
	
	public static function Info($message);
	public static function Fine($message);
	public static function Notice($message);
	public static function Debug($message);
	public static function Warn($message);
	public static function Error($message);
	public static function Fatal($message);
	
}

?>