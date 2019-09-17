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



class Design_0_0_AlienMovement extends ActorScript
{
	public var _MovementSpeed:Float;
	public var _SlidandIncreasedforSelf:Bool;
	
	
	public function new(dummy:Int, actor:Actor, dummy2:Engine)
	{
		super(actor);
		nameMap.set("Actor", "actor");
		nameMap.set("Movement Speed", "_MovementSpeed");
		_MovementSpeed = 2.0;
		nameMap.set("Slid and Increased for Self", "_SlidandIncreasedforSelf");
		_SlidandIncreasedforSelf = false;
		
	}
	
	override public function init()
	{
		
		/* ======================== When Updating ========================= */
		addWhenUpdatedListener(null, function(elapsedTime:Float, list:Array<Dynamic>):Void
		{
			if(wrapper.enabled)
			{
				/* Reached an edge. Slide down towards the
player and increase the movement speed. */
				if((Engine.engine.getGameAttribute("Slide and Increase Speed") : Bool))
				{
					if(!(_SlidandIncreasedforSelf))
					{
						_SlidandIncreasedforSelf = true;
						actor.moveBy(0, 16, 0.2, Easing.linear);
						_MovementSpeed = (_MovementSpeed + 1);
						runLater(1000 * 0.02, function(timeTask:TimedTask):Void
						{
							Engine.engine.setGameAttribute("Slide and Increase Speed", false);
							_SlidandIncreasedforSelf = false;
						}, actor);
					}
				}
				/* Reached the left side. Switch direction. */
				if((actor.getX() <= 2))
				{
					if(!((Engine.engine.getGameAttribute("Move Right") : Bool)))
					{
						Engine.engine.setGameAttribute("Slide and Increase Speed", true);
						Engine.engine.setGameAttribute("Move Right", true);
					}
				}
				/* Reached the right side. Switch direction. */
				if(((actor.getX() + (actor.getWidth())) >= (getSceneWidth() - 2)))
				{
					if((Engine.engine.getGameAttribute("Move Right") : Bool))
					{
						Engine.engine.setGameAttribute("Slide and Increase Speed", true);
						Engine.engine.setGameAttribute("Move Right", false);
					}
				}
				/* Make the aliens move left or right
at a constant rate. */
				if((Engine.engine.getGameAttribute("Move Right") : Bool))
				{
					actor.setXVelocity(_MovementSpeed);
				}
				else
				{
					actor.setXVelocity(-(_MovementSpeed));
				}
				/* They reached the end. You die. */
				if((actor.getY() >= (getSceneHeight() - 159)))
				{
					reloadCurrentScene(createFadeOut(0.3), createFadeIn(0.3));
				}
			}
		});
		
	}
	
	override public function forwardMessage(msg:String)
	{
		
	}
}