package repositorio.mongo

import domain.Producto
import domain.ProductoCompuesto
import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.commons.model.annotations.Observable
import repositorio.interfaces.RepoProducto

@Accessors
@Observable
class RepoProductoMongo extends RepoDefaultMongo<Producto> implements RepoProducto {

	static RepoProductoMongo instance

	static def getInstance() {
		if (instance === null) {
			instance = new RepoProductoMongo()
		}
		return instance
	}

	override getEntityType() {
		typeof(Producto)
	}

	override search(String descripcionBuscada, Integer stockMinimoABuscar, Integer stockMaximoABuscar,
		boolean soloDebajoStockMinimo) {
		val query = ds.createQuery(entityType)
		
		if (descripcionBuscada !== null) {
			query.field("descripcion").startsWithIgnoreCase(descripcionBuscada)
		}
		if (stockMinimoABuscar !== null) {
			query.field("stockAct").greaterThan(stockMinimoABuscar)
		}
		if (stockMaximoABuscar !== null) {
			query.field("stockAct").lessThan(stockMaximoABuscar)
		}
		if (soloDebajoStockMinimo) {
			query.where("this.stockAct< this.stockMin")
		}

		query.asList
	}

	override searchById(Producto producto) {
		val query = ds.createQuery(entityType)

		query.field("_id").equal(producto.idProductoMongo)
		query.get() as ProductoCompuesto

	}

	override searchProducto(Producto producto) {
		val query = ds.createQuery(entityType)

		query.field("_id").equal(producto.idProductoMongo)
		query.get()
	}

	override defineUpdateOperations(Producto producto) {
		val operations = ds.createUpdateOperations(entityType)
		operations.set("descripcion", producto.descripcion)
		operations.set("stockAct", producto.stockAct)
	}

}
