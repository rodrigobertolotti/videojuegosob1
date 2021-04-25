package entities;

import com.collision.platformer.CollisionGroup;
import com.collision.platformer.CollisionBox;
import kha.input.KeyCode;
import com.framework.utils.Input;
import kha.math.FastVector2;
import com.gEngine.display.Layer;
import com.gEngine.helpers.RectangleDisplay;
import com.framework.utils.Entity;

class Shooter extends Entity {
	var display:RectangleDisplay;

	public var collision:CollisionBox;

	var layer:Layer;
	var speed:Float = 100;
	var facingDir:FastVector2 = new FastVector2();
	var width:Float = 20;
	var height:Float = 20;

	public var bulletCollision:CollisionGroup;

	public function new(x:Float, y:Float, lay:Layer) {
		super();
		layer = lay;
		display = new RectangleDisplay();
		display.setColor(0, 0, 255);
		display.scaleX = width;
		display.scaleY = height;
		display.x = x;
		display.y = y;
		layer.addChild(display);

		collision = new CollisionBox();
		collision.width = width;
		collision.height = height;
		collision.x = x;
		collision.y = y;
		collision.dragX = 0.9;
		collision.dragY = 0.9;

		bulletCollision = new CollisionGroup();
	}

	override function update(dt:Float) {
		super.update(dt);
		moveShooter();
		if (Input.i.isKeyCodePressed(KeyCode.Space)) {
			var bullet:Bullet = new Bullet(collision.x + width * 0.5, collision.y + height * 0.5, facingDir, layer, bulletCollision);
			addChild(bullet);
		}
		collision.update(dt);
	}

	function moveShooter() {
		var dir:FastVector2 = new FastVector2();
		if (Input.i.isKeyCodeDown(KeyCode.Left)) {
			dir.x += -1;
		}
		if (Input.i.isKeyCodeDown(KeyCode.Right)) {
			dir.x += 1;
		}
		if (Input.i.isKeyCodeDown(KeyCode.Up)) {
			dir.y += -1;
		}
		if (Input.i.isKeyCodeDown(KeyCode.Down)) {
			dir.y += 1;
		}
		if (dir.length != 0) {
			var normalizeDir = dir.normalized();
			var finalVelocity = normalizeDir.mult(speed);
			collision.velocityX = finalVelocity.x;
			collision.velocityY = finalVelocity.y;
			facingDir.x = dir.x;
			facingDir.y = dir.y;
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
	}
}
