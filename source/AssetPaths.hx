package;

@:build(flixel.system.FlxAssets.buildFileReferences("assets", true))
class AssetPaths
{
	inline public static var SOUND_EXT = #if web "mp3" #else "ogg" #end;
}
