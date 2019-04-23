package viewModel

import domain.Producto
import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.commons.model.annotations.Dependencies
import org.uqbar.commons.model.annotations.Observable
import repositorio.persistencias.RepoManagerProductos

@Observable
@Accessors
class DetalleProductokModel {

	var Producto productoSeleccionado
	var int cantidadAVender

	new(Producto producto) {
		productoSeleccionado = producto
	}

	def vender() {
		productoSeleccionado.vender(cantidadAVender)
		val repoProducto = RepoManagerProductos.instance

		repoProducto.update(productoSeleccionado)
	}

	@Dependencies("productoSeleccionado.stockAct")
	def getHabilitarVenta() {
		productoSeleccionado.getStockAct > 0
	}
}
