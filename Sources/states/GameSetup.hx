package states;

import com.gEngine.display.Sprite;
import hxGeomAlgo.EarCut.EarNode;
import com.gEngine.helpers.Screen;
import com.gEngine.display.Text;
import com.loading.basicResources.FontLoader;
import com.loading.basicResources.JoinAtlas;
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
import states.EndGame;

class GameSetup extends State {
	var simulationLayer:Layer;
	var shooter:Shooter;
	var ball:Ball;
	var ball1:Ball;
	var button:Button;
	var ballCollisionGroup:CollisionGroup = new CollisionGroup();
	var screenHeight:Int;
	var screenWidth:Int;
	var score:Int;
	var text:Text;
	var ballsKilled:Int;

	override function load(resources:Resources) {
		resources.add(new ImageLoader("background"));
		resources.add(new ImageLoader("ball"));
		var atlas = new JoinAtlas(512, 512);
		atlas.add(new FontLoader("InterstateMono", 18));
		resources.add(atlas);
	}

	override function init() {
		var background = new Sprite("background");
		stage.addChild(background);
		this.text = new Text("InterstateMono");
		this.score = 0;
		this.ballsKilled = 0;
		text.x = Screen.getWidth() * 0.8;
		text.y = Screen.getHeight() * 0.1;
		text.text = "Score: " + this.score;
		stage.addChild(text);

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

	function setScore(score:Int) {
		this.score = score;
	}

	override function update(dt:Float) {
		super.update(dt);
		this.text.text = "ENEMIGOS: " + this.score + "/10";
		CollisionEngine.overlap(shooter.bulletCollision, ballCollisionGroup, bulletVsBall);
		CollisionEngine.overlap(shooter.collision, ballCollisionGroup, shooterVsBall);
		MainLayer.destroy();
	}

	function bulletVsBall(bullet:ICollider, ballTarget:ICollider) {
		var bullet:Bullet = cast bullet.userData;
		var ballDead:Ball = cast ballTarget.userData;
		this.score++;
		if (this.score == 2) {
			changeState(new EndGame(true));
		} else {
			if (ballDead.life < 2) {
				ballDead.die();
				this.ballsKilled++;
				if (this.ballsKilled % 2 != 0) {
					createBall();
				}
			} else {
				ballDead.shot();
			}
		}

		bullet.die();
	}

	function shooterVsBall(shooter:ICollider, ballTarget:ICollider) {
		this.shooter.die();
		changeState(new EndGame(false));
	}

	function createBall() {
		var width:Int = Std.random(this.screenWidth);
		var height:Int = Std.random(this.screenHeight);
		ball = new Ball(width, height, simulationLayer, ballCollisionGroup);
		addChild(ball);
	}

	function onMouseDown(button:Int, x:Int, y:Int) {
		if (x >= 0 && x <= 100 && y >= 0 && y <= 100) {
			createBall();
		}
	}

	override function destroy() {
		super.destroy();
		MainLayer.destroy();
	}
}
