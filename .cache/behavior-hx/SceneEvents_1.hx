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
import box2D.collision.shapes.B2Shape;

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



class SceneEvents_1 extends SceneScript
{
	
	
	public function new(dummy:Int, dummy2:Engine)
	{
		super();
		
	}
	
	override public function init()
	{
		
		/* ======================== When Creating ========================= */
		Engine.engine.setGameAttribute("EnemyCount", 26);
		
		/* =========================== Keyboard =========================== */
		addKeyStateListener("up", function(pressed:Bool, released:Bool, list:Array<Dynamic>):Void
		{
			if(wrapper.enabled && pressed)
			{
				Engine.engine.setGameAttribute("BulletNo", ((Engine.engine.getGameAttribute("BulletNo") : Float) + 1));
			}
		});
		
		/* =========================== Keyboard =========================== */
		addKeyStateListener("down", function(pressed:Bool, released:Bool, list:Array<Dynamic>):Void
		{
			if(wrapper.enabled && pressed)
			{
				Engine.engine.setGameAttribute("BulletNo", ((Engine.engine.getGameAttribute("BulletNo") : Float) - 1));
			}
		});
		
		/* ========================= Type & Type ========================== */
		addSceneCollisionListener(getActorType(37).ID, getActorType(39).ID, function(event:Collision, list:Array<Dynamic>):Void
		{
			if(wrapper.enabled)
			{
				recycleActor(event.thisActor);
				event.otherActor.setAnimation("Warning");
				runLater(1000 * 1.1, function(timeTask:TimedTask):Void
				{
					event.otherActor.setAnimation("Animation 0");
					Engine.engine.setGameAttribute("BossHP", ((Engine.engine.getGameAttribute("BossHP") : Float) - 1));
					if(((Engine.engine.getGameAttribute("BossHP") : Float) == 0))
					{
						event.otherActor.shout("_customEvent_" + "HandleDeath");
						recycleActor(event.otherActor);
						runLater(1000 * 1, function(timeTask:TimedTask):Void
						{
							switchScene(GameModel.get().scenes.get(3).getID(), null, createSlideDownTransition(0));
						}, null);
					}
				}, null);
			}
		});
		
		/* ======================== When Updating ========================= */
		addWhenUpdatedListener(null, function(elapsedTime:Float, list:Array<Dynamic>):Void
		{
			if(wrapper.enabled)
			{
				if(((Engine.engine.getGameAttribute("EnemyCount") : Float) == 0))
				{
					if(((Engine.engine.getGameAttribute("DidBossSpawn") : Bool) == false))
					{
						createRecycledActor(getActorType(39), 250, 20, Script.FRONT);
						Engine.engine.setGameAttribute("DidBossSpawn", true);
					}
				}
			}
		});
		
		/* ========================= Type & Type ========================== */
		addSceneCollisionListener(getActorType(35).ID, getActorType(39).ID, function(event:Collision, list:Array<Dynamic>):Void
		{
			if(wrapper.enabled)
			{
				recycleActor(event.thisActor);
				event.otherActor.setAnimation("Warning");
				runLater(1000 * 1.1, function(timeTask:TimedTask):Void
				{
					event.otherActor.setAnimation("Animation 0");
					Engine.engine.setGameAttribute("BossHP", ((Engine.engine.getGameAttribute("BossHP") : Float) - 1));
					if(((Engine.engine.getGameAttribute("BossHP") : Float) == 0))
					{
						event.otherActor.shout("_customEvent_" + "HandleDeath");
						recycleActor(event.otherActor);
						runLater(1000 * 1, function(timeTask:TimedTask):Void
						{
							switchScene(GameModel.get().scenes.get(3).getID(), null, createSlideDownTransition(0));
						}, null);
					}
				}, null);
			}
		});
		
		/* ========================= Type & Type ========================== */
		addSceneCollisionListener(getActorType(9).ID, getActorType(39).ID, function(event:Collision, list:Array<Dynamic>):Void
		{
			if(wrapper.enabled)
			{
				recycleActor(event.thisActor);
				event.otherActor.setAnimation("Warning");
				runLater(1000 * 1.1, function(timeTask:TimedTask):Void
				{
					event.otherActor.setAnimation("Animation 0");
					Engine.engine.setGameAttribute("BossHP", ((Engine.engine.getGameAttribute("BossHP") : Float) - 1));
					if(((Engine.engine.getGameAttribute("BossHP") : Float) == 0))
					{
						event.otherActor.shout("_customEvent_" + "HandleDeath");
						recycleActor(event.otherActor);
						runLater(1000 * 1, function(timeTask:TimedTask):Void
						{
							switchScene(GameModel.get().scenes.get(3).getID(), null, createSlideDownTransition(0));
						}, null);
					}
				}, null);
			}
		});
		
		/* ========================= Type & Type ========================== */
		addSceneCollisionListener(getActorType(33).ID, getActorType(39).ID, function(event:Collision, list:Array<Dynamic>):Void
		{
			if(wrapper.enabled)
			{
				recycleActor(event.thisActor);
				event.otherActor.setAnimation("Warning");
				runLater(1000 * 1.1, function(timeTask:TimedTask):Void
				{
					event.otherActor.setAnimation("Animation 0");
					Engine.engine.setGameAttribute("BossHP", ((Engine.engine.getGameAttribute("BossHP") : Float) - 1));
					if(((Engine.engine.getGameAttribute("BossHP") : Float) == 0))
					{
						event.otherActor.shout("_customEvent_" + "HandleDeath");
						recycleActor(event.otherActor);
						runLater(1000 * 1, function(timeTask:TimedTask):Void
						{
							switchScene(GameModel.get().scenes.get(3).getID(), null, createSlideDownTransition(0));
						}, null);
					}
				}, null);
			}
		});
		
	}
	
	override public function forwardMessage(msg:String)
	{
		
	}
}