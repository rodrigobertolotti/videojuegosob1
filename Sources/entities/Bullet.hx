package entities;

import com.collision.platformer.CollisionGroup;
import kha.math.FastVector2;
import com.gEngine.display.Layer;
import com.gEngine.helpers.RectangleDisplay;
import com.framework.utils.Entity;
import com.collision.platformer.CollisionBox;

class Bullet extends Entity {
	var display:RectangleDisplay;
	var collision:CollisionBox;
	var speed:Float = 600;
	var width:Float = 20;
	var height:Float = 20;
	var time:Float = 0;

	public function new(x:Float, y:Float, dir:FastVector2, layer:Layer, collisionGroup:CollisionGroup) {
		super();

		display = new RectangleDisplay();
		display.setColor(0, 0, 255);
		display.scaleX = width;
		display.scaleY = height;
		layer.addChild(display);

		collision = new CollisionBox();
		collision.width = width;
		collision.height = height;
		collision.x = x;
		collision.y = y;
		collision.velocityX = dir.x * speed;
		collision.velocityY = dir.y * speed;
		collision.userData = this;
		collisionGroup.add(collision);
	}

	override function update(dt:Float) {
		super.update(dt);
		collision.update(dt);
		if (time > 4) {
			die();
		}
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
