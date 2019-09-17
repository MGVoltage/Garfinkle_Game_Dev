package scripts;

import com.stencyl.graphics.G;
import com.stencyl.graphics.BitmapWrapper;
import com.stencyl.graphics.ScaleMode;

import com.stencyl.behavior.Script;
import com.stencyl.behavior.Script.*;
import com.stencyl.behavior.ActorScript;
import com.stencyl.behavior.SceneScript;
import com.stencyl.behavior.TimedTask;

import com.stencyl.models.Actor;
import com.stencyl.models.GameModel;
import com.stencyl.models.actor.Animation;
import com.stencyl.models.actor.ActorType;
import com.stencyl.models.actor.Collision;
import com.stencyl.models.actor.Group;
import com.stencyl.models.Scene;
import com.stencyl.models.Sound;
import com.stencyl.models.Region;
import com.stencyl.models.Font;
import com.stencyl.models.Joystick;

import com.stencyl.Config;
import com.stencyl.Engine;
import com.stencyl.Input;
import com.stencyl.Key;
import com.stencyl.utils.motion.*;
import com.stencyl.utils.Utils;

import openfl.ui.Mouse;
import openfl.display.Graphics;
import openfl.display.BlendMode;
import openfl.display.BitmapData;
import openfl.display.Bitmap;
import openfl.events.Event;
import openfl.events.KeyboardEvent;
import openfl.events.TouchEvent;
import openfl.net.URLLoader;

import box2D.common.math.B2Vec2;
import box2D.dynamics.B2Body;
import box2D.dynamics.B2Fixture;
import box2D.dynamics.joints.B2Joint;

import com.stencyl.graphics.shaders.BasicShader;
import com.stencyl.graphics.shaders.GrayscaleShader;
import com.stencyl.graphics.shaders.SepiaShader;
import com.stencyl.graphics.shaders.InvertShader;
import com.stencyl.graphics.shaders.GrainShader;
import com.stencyl.graphics.shaders.ExternalShader;
import com.stencyl.graphics.shaders.InlineShader;
import com.stencyl.graphics.shaders.BlurShader;
import com.stencyl.graphics.shaders.SharpenShader;
import com.stencyl.graphics.shaders.ScanlineShader;
import com.stencyl.graphics.shaders.CSBShader;
import com.stencyl.graphics.shaders.HueShader;
import com.stencyl.graphics.shaders.TintShader;
import com.stencyl.graphics.shaders.BloomShader;



class Design_7_7_FireBullet extends ActorScript
{
	public var trigger:String;
	public var speed:Float;
	public var spawned:Actor;
	public var bullet:ActorType;
	public var shooterangle:Float;
	public var bulletangle:Float;
	public var sound:Sound;
	public var _CanFire:Bool;
	public var _BulletCreated:Actor;
	public var _Fired:Bool;
	public var _YOffset:Float;
	public var _XOffset:Float;
	public function _customEvent_whenThisHearstrigger():Void
	{
		if(_Fired)
		{
			if(!(_BulletCreated.isAlive()))
			{
				_CanFire = false;
				_Fired = true;
				createRecycledActor(bullet, (actor.getXCenter() + _XOffset), (actor.getYCenter() + _YOffset), Script.BACK);
				_BulletCreated = getLastCreatedActor();
				getLastCreatedActor().setX((getLastCreatedActor().getX() - ((getLastCreatedActor().getWidth()) / 2)));
				getLastCreatedActor().setY((getLastCreatedActor().getY() - ((getLastCreatedActor().getHeight()) / 2)));
				getLastCreatedActor().setAngle(Utils.RAD * ((((Utils.DEG * actor.getAngle()) + shooterangle) - bulletangle)));
				getLastCreatedActor().setVelocity((((Utils.DEG * actor.getAngle()) + shooterangle) - 180), speed);
				playSound(sound);
			}
		}
		else
		{
			_CanFire = false;
			_Fired = true;
			createRecycledActor(bullet, actor.getXCenter(), actor.getYCenter(), Script.MIDDLE);
			_BulletCreated = getLastCreatedActor();
			getLastCreatedActor().setX((getLastCreatedActor().getX() - ((getLastCreatedActor().getWidth()) / 2)));
			getLastCreatedActor().setY((getLastCreatedActor().getY() - ((getLastCreatedActor().getHeight()) / 2)));
			getLastCreatedActor().setAngle(Utils.RAD * ((((Utils.DEG * actor.getAngle()) + shooterangle) - bulletangle)));
			getLastCreatedActor().setVelocity((((Utils.DEG * actor.getAngle()) + shooterangle) - 180), speed);
			playSound(sound);
		}
	}
	
	
	public function new(dummy:Int, actor:Actor, dummy2:Engine)
	{
		super(actor);
		nameMap.set("Actor", "actor");
		nameMap.set("Triggering Message", "trigger");
		trigger = "";
		nameMap.set("Speed", "speed");
		speed = 0.0;
		nameMap.set("spawned", "spawned");
		nameMap.set("Bullet", "bullet");
		nameMap.set("Inital Shooter Angle", "shooterangle");
		shooterangle = 0.0;
		nameMap.set("Inital Bullet Angle", "bulletangle");
		bulletangle = 270.0;
		nameMap.set("Sound to Play", "sound");
		nameMap.set("Can Fire?", "_CanFire");
		_CanFire = true;
		nameMap.set("Bullet Created", "_BulletCreated");
		nameMap.set("Fired", "_Fired");
		_Fired = false;
		nameMap.set("Y Offset", "_YOffset");
		_YOffset = 0.0;
		nameMap.set("X Offset", "_XOffset");
		_XOffset = 0.0;
		
	}
	
	override public function init()
	{
		
	}
	
	override public function forwardMessage(msg:String)
	{
		if(msg == ("_customEvent_" + trigger))
		{
			_customEvent_whenThisHearstrigger();
			return;
		}
		
	}
}