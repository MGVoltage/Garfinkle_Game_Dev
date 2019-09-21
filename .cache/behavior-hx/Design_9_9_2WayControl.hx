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



class Design_9_9_2WayControl extends ActorScript
{
	public var pressedLeft:Bool;
	public var pressedRight:Bool;
	public var controlLeft:String;
	public var controlRight:String;
	public var dir:Float;
	public var topSpeed:Float;
	public var decel:Float;
	public function _customEvent_moveRight():Void
	{
		actor.setXVelocity(topSpeed);
		dir = 4;
	}
	public function _customEvent_checkInput():Void
	{
		pressedLeft = isKeyDown(controlLeft);
		pressedRight = isKeyDown(controlRight);
	}
	public function _customEvent_moveLeft():Void
	{
		actor.setXVelocity(-(topSpeed));
		dir = 3;
	}
	
	
	public function new(dummy:Int, actor:Actor, dummy2:Engine)
	{
		super(actor);
		nameMap.set("Actor", "actor");
		nameMap.set("pressedLeft", "pressedLeft");
		pressedLeft = false;
		nameMap.set("pressedRight", "pressedRight");
		pressedRight = false;
		nameMap.set("Left Control", "controlLeft");
		nameMap.set("Right Control", "controlRight");
		nameMap.set("Initial Direction", "dir");
		dir = 0.0;
		nameMap.set("Top Speed", "topSpeed");
		topSpeed = 18.0;
		nameMap.set("Slowdown Rate", "decel");
		decel = 0.0;
		
	}
	
	override public function init()
	{
		
		/* ======================== When Updating ========================= */
		addWhenUpdatedListener(null, function(elapsedTime:Float, list:Array<Dynamic>):Void
		{
			if(wrapper.enabled)
			{
				_customEvent_checkInput();
				if((!(pressedLeft) && !(pressedRight)))
				{
					actor.setXVelocity((actor.getXVelocity() * decel));
				}
				if((pressedLeft && !(pressedRight)))
				{
					_customEvent_moveLeft();
					actor.setYVelocity(0);
				}
				else
				{
					if((pressedRight && !(pressedLeft)))
					{
						_customEvent_moveRight();
						actor.setYVelocity(0);
					}
				}
				if((actor.getXVelocity() > topSpeed))
				{
					actor.setXVelocity(topSpeed);
				}
				else
				{
					if((actor.getXVelocity() < -(topSpeed)))
					{
						actor.setXVelocity(-(topSpeed));
					}
				}
			}
		});
		
	}
	
	override public function forwardMessage(msg:String)
	{
		
	}
}