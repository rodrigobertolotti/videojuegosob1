package entities;

import com.collision.platformer.CollisionGroup;
import com.gEngine.GEngine;
import kha.math.FastVector2;
import com.collision.platformer.CollisionBox;
import com.gEngine.display.Layer;
import com.gEngine.helpers.RectangleDisplay;
import com.framework.utils.Entity;

class Ball extends Entity {
	var display:RectangleDisplay;

	var width:Float = 50;
	var height:Float = 50;
	var velocity:FastVector2;
	var position:FastVector2;
	var speed:Float = 50;
	var direction:Float = 1;
	var screenWidth:Int;
	var screenHeight:Int;
	var collisionGroup:CollisionGroup;
	var collision:CollisionBox;

	public var life:Int = 2;

	public function new(x:Float, y:Float, layer:Layer, collisionGroup:CollisionGroup) {
		super();
		display = new RectangleDisplay();
		display.x = x;
		display.y = y;
		display.scaleX = width;
		display.scaleY = height;
		display.setColor(255, 0, 0);
		layer.addChild(display);

		this.screenWidth = GEngine.i.width;
		this.screenHeight = GEngine.i.height;

		velocity = new FastVector2(x, y);
		position = new FastVector2(x, y);

		collision = new CollisionBox();
		collision.x = x;
		collision.y = y;
		collision.width = width;
		collision.height = height;
		collision.userData = this;
		collisionGroup.add(collision);
	}

	override function update(dt:Float) {
		super.update(dt);
		collision.update(dt);
		velocity.y += speed * dt;
		position.y += velocity.y * dt;
		collision.y = position.y;
		velocity.x += speed * dt;
		position.x += velocity.x * dt;
		collision.x = position.x;
		if (position.y >= screenHeight - (this.height / 2) || position.y <= 0 + (this.height / 2)) {
			velocity.y *= -1;
		}
		if (position.x >= screenWidth - (this.height / 2) || position.x <= 0 + (this.width / 2)) {
			velocity.x *= -1;
		}
	}

	public function shot() {
		this.display.setColor(0, 255, 0);
		this.life = this.life - 1;
	}

	override function render() {
		super.render();
		display.x = collision.x;
		display.y = collision.y;
	}

	override function destroy() {
		super.destroy();
		display.removeFromParent();
		collision.removeFromParent();
	}
}
