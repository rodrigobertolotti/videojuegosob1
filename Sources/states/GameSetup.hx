package states;

import kha.math.Matrix2;
import com.collision.platformer.CollisionGroup;
import com.collision.platformer.ICollider;
import entities.Bullet;
import com.collision.platformer.CollisionEngine;
import com.gEngine.display.Layer;
import com.framework.utils.State;
import entities.Shooter;
import entities.Ball;
import screen.Button;
import com.loading.basicResources.ImageLoader;
import com.loading.Resources;
import kha.input.Mouse;
import com.gEngine.GEngine;

class GameSetup extends State {
	var simulationLayer:Layer;
	var shooter:Shooter;
	var ball:Ball;
	var button:Button;
	var ballCollisionGroup:CollisionGroup = new CollisionGroup();
	var screenHeight:Int;
	var screenWidth:Int;

	override function load(resources:Resources) {
		resources.add(new ImageLoader("ball"));
	}

	override function init() {
		this.screenWidth = GEngine.i.width;
		this.screenHeight = GEngine.i.height;
		simulationLayer = new Layer();
		stage.addChild(simulationLayer);
		MainLayer.simulationLayer = simulationLayer;
		Mouse.get().notify(onMouseDown, null, null, null);

		button = new Button(10, 10, simulationLayer);
		shooter = new Shooter(100, 100, simulationLayer);
		ball = new Ball(300, 300, simulationLayer, ballCollisionGroup);

		addChild(shooter);
		addChild(ball);
	}

	override function update(dt:Float) {
		super.update(dt);
		CollisionEngine.overlap(shooter.bulletCollision, ballCollisionGroup, bulletVsBall);
		MainLayer.destroy();
	}

	function bulletVsBall(bullet:ICollider, ballTarget:ICollider) {
		var bullet:Bullet = cast bullet.userData;
		var ballDead:Ball = cast ballTarget.userData;
		bullet.die();
		ballDead.die();
	}

	function createBall(x:Float, y:Float) {
		ball = new Ball(x, y, simulationLayer, ballCollisionGroup);
		addChild(ball);
	}

	function onMouseDown(button:Int, x:Int, y:Int) {
		if (x >= 0 && x <= 100 && y >= 0 && y <= 100) {
			var width:Int = Std.random(this.screenWidth);
			var height:Int = Std.random(this.screenHeight);
			createBall(width, height);
		}
	}

	override function destroy() {
		super.destroy();
		MainLayer.destroy();
	}
}
