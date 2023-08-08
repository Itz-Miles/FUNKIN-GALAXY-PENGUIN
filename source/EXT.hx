package;

class EXT
{
	public static var AUDIO_EXT = #if web "mp3" #else "ogg" #end;
	public static var DATA_EXT = "json";
	public static var ANIM_EXT = "xml";

	public static inline function sound(filename:String):String
	{
		return 'assets/sounds/${filename}.${AUDIO_EXT}';
	}

	public static inline function music(filename:String):String
	{
		return 'assets/music/${filename}.${AUDIO_EXT}';
	}

	public static inline function json(filename:String):String
	{
		return 'assets/data/${filename}.${DATA_EXT}';
	}

	public static inline function xml(filename:String):String
	{
		return 'assets/images/${filename}-anim.${ANIM_EXT}';
	}
}
