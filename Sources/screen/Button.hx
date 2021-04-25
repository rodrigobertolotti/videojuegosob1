package screen;

import com.gEngine.display.Layer;
import com.framework.utils.State;
import com.gEngine.display.Sprite;
import com.loading.basicResources.ImageLoader;
import com.loading.Resources;

class Button extends State {
	var button:Sprite;
	var x:Float;
	var y:Float;
	var layer:Layer;

	public function new(x:Float, y:Float, layer:Layer) {
		super();
		button = new Sprite("ball");
		button.x = x;
		button.y = y;
		layer.addChild(button);
	}

	override function update(dt:Float) {
		super.update(dt);
	}

	override function render() {
		super.render();
	}
}
