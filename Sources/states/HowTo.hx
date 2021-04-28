package states;

import kha.Color;
import kha.input.KeyCode;
import com.framework.utils.Input;
import com.loading.basicResources.JoinAtlas;
import com.loading.Resources;
import com.framework.utils.State;
import states.GameSetup;
import com.gEngine.helpers.Screen;
import com.gEngine.display.Text;
import com.loading.basicResources.FontLoader;

class HowTo extends State {
	var message:String;
	var title:String;
	var textStart:String;

	public function new() {
		super();
	}

	override function load(resources:Resources) {
		var atlas = new JoinAtlas(512, 512);
		atlas.add(new FontLoader("InterstateMono", 24));
		resources.add(atlas);
	}

	override function init() {
		var text = new Text("InterstateMono");
		var title = new Text("InterstateMono");
		var textStart = new Text("InterstateMono");
		this.stageColor(0, 0, 0);
		title.text = "Bienvenido al obligatorio 1 de Rodrigo Bertolotti.";
		text.text = "Flechas para moverse, X para disparar. Ganas si llegas a 10 puntos y pierdes si te toca un invasor.";
		textStart.text = "Presiona ESPACIO para comenzar.";
		text.color = Color.White;
		title.x = Screen.getWidth() * 0.3;
		title.y = Screen.getHeight() * 0.3;
		text.x = Screen.getWidth() * 0.05;
		text.y = Screen.getHeight() * 0.5;
		textStart.x = Screen.getWidth() * 0.4;
		textStart.y = Screen.getHeight() * 0.7;
		stage.addChild(title);
		stage.addChild(text);
		stage.addChild(textStart);
	}

	override function update(dt:Float) {
		super.update(dt);
		if (Input.i.isKeyCodePressed(KeyCode.Space)) {
			this.changeState(new GameSetup());
		}
	}
}
