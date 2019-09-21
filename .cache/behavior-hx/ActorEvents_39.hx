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



class ActorEvents_39 extends ActorScript
{
	public var _MovementSpeed:Float;
	public var _SlidandIncreasedforSelf:Bool;
	
	
	public function new(dummy:Int, actor:Actor, dummy2:Engine)
	{
		super(actor);
		nameMap.set("Movement Speed", "_MovementSpeed");
		_MovementSpeed = 2.0;
		nameMap.set("Slid and Increased for Self", "_SlidandIncreasedforSelf");
		_SlidandIncreasedforSelf = false;
		
	}
	
	override public function init()
	{
		
		/* ======================== Actor of Type ========================= */
		addCollisionListener(actor, function(event:Collision, list:Array<Dynamic>):Void
		{
			if(wrapper.enabled && sameAsAny(getActorType(1), event.otherActor.getType(),event.otherActor.getGroup()))
			{
				recycleActor(event.otherActor);
				reloadCurrentScene(createFadeOut(0.3), createFadeIn(0.3));
			}
		});
		
		/* ======================= Member of Group ======================== */
		addCollisionListener(actor, function(event:Collision, list:Array<Dynamic>):Void
		{
			if(wrapper.enabled && sameAsAny(getActorGroup(3),event.otherActor.getType(),event.otherActor.getGroup()))
			{
				recycleActor(event.otherActor);
				reloadCurrentScene(createFadeOut(0.3), createFadeIn(0.3));
			}
		});
		
		/* ======================== When Updating ========================= */
		addWhenUpdatedListener(null, function(elapsedTime:Float, list:Array<Dynamic>):Void
		{
			if(wrapper.enabled)
			{
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
					actor.setXVelocity(3);
				}
				else
				{
					actor.setXVelocity(-3);
				}
			}
		});
		
		/* ======================= Every N seconds ======================== */
		runPeriodically(1000 * 8, function(timeTask:TimedTask):Void
		{
			if(wrapper.enabled)
			{
				actor.setXVelocity(0);
				actor.setAnimation("Warning");
				runLater(1000 * 2, function(timeTask:TimedTask):Void
				{
					actor.setAnimation("Attack");
					actor.moveBy(0, 400, 1.5, Easing.expoIn);
					runLater(1000 * 2, function(timeTask:TimedTask):Void
					{
						actor.moveBy(0, -400, 1.5, Easing.expoOut);
						actor.setAnimation("Boss");
						runLater(1000 * 0.5, function(timeTask:TimedTask):Void
						{
							actor.setXVelocity(3);
						}, actor);
					}, actor);
				}, actor);
			}
		}, actor);
		
	}
	
	override public function forwardMessage(msg:String)
	{
		
	}
}