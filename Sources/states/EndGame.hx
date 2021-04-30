package states;

import kha.Color;
import com.loading.basicResources.FontLoader;
import com.gEngine.display.IContainer;
import com.framework.utils.VirtualGamepad;
import com.gEngine.display.Sprite;
import com.loading.basicResources.ImageLoader;
import kha.input.KeyCode;
import com.framework.utils.Input;
import com.loading.basicResources.JoinAtlas;
import com.loading.Resources;
import com.framework.utils.State;
import states.GameSetup;
import com.gEngine.helpers.Screen;
import com.gEngine.display.Text;
import com.loading.basicResources.FontLoader;

class EndGame extends State {
	var winState:Bool;
	var image:Sprite;
	var message:String;

	public function new(winState:Bool) {
		super();
		this.winState = winState;
	}

	override function load(resources:Resources) {
		var atlas = new JoinAtlas(512, 512);
		atlas.add(new ImageLoader("won"));
		atlas.add(new ImageLoader("lost"));
		atlas.add(new FontLoader("InterstateMono", 24));
		resources.add(atlas);
	}

	override function init() {
		var text = new Text("InterstateMono");
		if (winState == true) {
			image = new Sprite("won");
			message = "GANASTE!";
		} else {
			image = new Sprite("lost");
			message = "PERDISTE";
		}
		this.stageColor(0, 0, 0);
		image.scaleX = 1;
		image.scaleY = 1;
		image.smooth = false;
		text.text = message + ". Para continuar jugando presione ESPACIO";
		text.color = Color.White;
		image.x = Screen.getWidth() * 0.5 - 150;
		image.y = Screen.getHeight() * 0.2;
		text.x = Screen.getWidth() * 0.5 - 300;
		text.y = Screen.getHeight() * 0.8;
		stage.addChild(image);
		stage.addChild(text);
	}

	override function update(dt:Float) {
		super.update(dt);
		if (Input.i.isKeyCodePressed(KeyCode.Space)) {
			this.changeState(new GameSetup());
		}
	}
}
