package runnable

import org.uqbar.arena.Application
import ui.AdministracionWindow
import org.uqbar.arena.windows.Window

class ProductosApplication extends Application {
	new(ProductosBootstrap bootstrap) {
	super(bootstrap)
	}

	static def void main(String[] args) {
		new ProductosApplication(new ProductosBootstrap).start()
	}

	override protected Window<?> createMainWindow() {
		return new AdministracionWindow(this)

	}
}