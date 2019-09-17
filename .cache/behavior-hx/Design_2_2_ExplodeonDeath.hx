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



class Design_2_2_ExplodeonDeath extends ActorScript
{
	public var _NumberofActorstoCreate:Float;
	public var _ExplosionForce:Float;
	public var _ActortoCreate:ActorType;
	public var _NumberofSecondActorstoCreate:Float;
	public var _SecondActortoCreate:ActorType;
	public var _ExplosionForceofSecondActors:Float;
	public var _SoundtoPlay:Sound;
	public function _customEvent_HandleDeath():Void
	{
		playSound(_SoundtoPlay);
		for(index0 in 0...Std.int(_NumberofActorstoCreate))
		{
			createRecycledActor(getActorType(11), (actor.getX() + (actor.getWidth()/2)), (actor.getY() + (actor.getHeight()/2)), Script.FRONT);
			getLastCreatedActor().applyImpulseInDirection(randomInt(1, 360), _ExplosionForce);
		}
		for(index0 in 0...Std.int(_NumberofSecondActorstoCreate))
		{
			createRecycledActor(getActorType(13), (actor.getX() + (actor.getWidth()/2)), (actor.getY() + (actor.getHeight()/2)), Script.FRONT);
			getLastCreatedActor().applyImpulseInDirection(randomInt(1, 360), _ExplosionForceofSecondActors);
		}
	}
	
	
	public function new(dummy:Int, actor:Actor, dummy2:Engine)
	{
		super(actor);
		nameMap.set("Actor", "actor");
		nameMap.set("Number of Actors to Create", "_NumberofActorstoCreate");
		_NumberofActorstoCreate = 10.0;
		nameMap.set("Explosion Force", "_ExplosionForce");
		_ExplosionForce = 1.0;
		nameMap.set("Actor to Create", "_ActortoCreate");
		_ActortoCreate = getActorType(11);
		nameMap.set("Number of Second Actors to Create", "_NumberofSecondActorstoCreate");
		_NumberofSecondActorstoCreate = 5.0;
		nameMap.set("Second Actor to Create", "_SecondActortoCreate");
		_SecondActortoCreate = getActorType(13);
		nameMap.set("Explosion Force of Second Actors", "_ExplosionForceofSecondActors");
		_ExplosionForceofSecondActors = 0.7;
		nameMap.set("Sound to Play", "_SoundtoPlay");
		_SoundtoPlay = getSound(15);
		
	}
	
	override public function init()
	{
		
	}
	
	override public function forwardMessage(msg:String)
	{
		
	}
}