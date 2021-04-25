package states;

import com.gEngine.display.Layer;

class MainLayer {
	static public var simulationLayer:Layer;

	static public function destroy() {
		simulationLayer = null;
	}
}
