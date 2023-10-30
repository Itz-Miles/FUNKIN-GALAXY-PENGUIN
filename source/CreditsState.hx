package;

import flixel.text.FlxText;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.input.keyboard.FlxKey;
import flixel.group.FlxGroup;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.util.FlxColor;
import flixel.util.FlxTimer;
import lime.app.Application;
import openfl.Assets;

using StringTools;

class CreditsState extends MusicBeatState
{
	override public function create():Void
	{
		super.create();

		if (FlxG.sound.music == null)
		{
			FlxG.sound.playMusic(EXT.music('title'), 0);

			FlxG.sound.music.fadeIn(4, 0, 1);
		}

		Conductor.changeBPM(72);

		var wall:FlxSprite = new FlxSprite(0, 0).loadGraphic(EXT.png('wall'));
		add(wall);

		FlxG.camera.flash(FlxColor.WHITE, 1.7);
	}

	override function update(elapsed:Float)
	{
		if (FlxG.sound.music != null)
			Conductor.songPosition = FlxG.sound.music.time;
		if (Controls.BACK)
			FlxG.switchState(new CreditsState());
		super.update(elapsed);
	}

	override function beatHit()
	{
		super.beatHit();
	}

	override public function destroy()
	{
		wall = null;
		super.destroy();
	}
}
