package repositorio.memoria

import domain.Producto
import domain.ProductoCompuesto
import org.apache.commons.collections15.Predicate
import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.commons.model.CollectionBasedRepo
import org.uqbar.commons.model.annotations.Observable
import repositorio.interfaces.RepoProducto

@Accessors
@Observable
class RepoProductoMemoria extends CollectionBasedRepo<Producto> implements RepoProducto{
	
	static RepoProductoMemoria instance

	static def getInstance() {
		if (instance === null) {
			instance = new RepoProductoMemoria()
		}
		return instance
	}
	

	override search(String descripcionBuscada, Integer stockMinimoABuscar, Integer stockMaximoABuscar,
		boolean soloDebajoStockMinimo) {
		allInstances.filter [ producto |
			this.match(descripcionBuscada, producto.descripcion) && busquedaStockMin(stockMinimoABuscar, producto) &&
				busquedaStockMax(stockMaximoABuscar, producto) &&
				(!soloDebajoStockMinimo || soloDebajoStockMinimo === producto.debajoStockMinimo)
		].toList
	}

	def match(Object expectedValue, Object realValue) {
		if (expectedValue === null) {
			return true
		}
		if (realValue === null) {
			return false
		}
		realValue.toString().toLowerCase().contains(expectedValue.toString().toLowerCase())
	}

	def busquedaStockMin(Integer stockBuscado, Producto productoReal) {
		if (stockBuscado === null) {
			return true
		}
		stockBuscado < productoReal.stockAct

	}

	def busquedaStockMax(Integer stockBuscado, Producto productoReal) {
		if (stockBuscado === null) {
			return true
		}
		stockBuscado > productoReal.stockAct

	}
	
	override def Predicate<Producto> getCriterio(Producto example) {
		null
	}
	
	override createExample() {
		new Producto
	}
	override getEntityType() {
		typeof(Producto)
	}
	
	override searchById(Producto producto) {
		producto as ProductoCompuesto
	}
	
	override searchProducto(Producto producto) {
		producto
	}

}
