package repositorio.mySQL

import domain.Producto
import domain.ProductoCompuesto
import java.util.List
import javax.persistence.criteria.CriteriaBuilder
import javax.persistence.criteria.CriteriaQuery
import javax.persistence.criteria.Predicate
import javax.persistence.criteria.Root
import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.commons.model.annotations.Observable
import repositorio.interfaces.RepoProducto

@Accessors
@Observable
class RepoProductoMySql extends RepoDefault<Producto> implements RepoProducto {

	static RepoProductoMySql instance

	static def getInstance() {
		if (instance === null) {
			instance = new RepoProductoMySql()
		}
		return instance
	}

	override getEntityType() {
		typeof(Producto)
	}

	def generateWhere(CriteriaBuilder criteria, CriteriaQuery<Producto> query, Root<Producto> producto,
		String descripcionBuscada, Integer stockMinimoABuscar, Integer stockMaximoABuscar,
		boolean soloDebajoStockMinimo) {

		var List<Predicate> condiciones = newArrayList

		if (descripcionBuscada !== null) {
			condiciones.add(criteria.like(producto.get("descripcion"), descripcionBuscada + "%"))
		}
		if (stockMinimoABuscar !== null) {
			condiciones.add(criteria.gt(producto.get("stockAct"), stockMinimoABuscar))
		}
		if (stockMaximoABuscar !== null) {
			condiciones.add(criteria.lt(producto.get("stockAct"), stockMaximoABuscar))
		}
		if (soloDebajoStockMinimo) {
			condiciones.add(criteria.lt(producto.get("stockAct"), producto.get("stockMin")))
		}
		query.where(condiciones)
	}

	override List<Producto> search(String descripcionBuscada, Integer stockMinimoABuscar, Integer stockMaximoABuscar,
		boolean soloDebajoStockMinimo) {
		val entityManager = this.entityManager
		try {
			val criteria = entityManager.criteriaBuilder
			// val query = criteria.createQuery<OrdenDeCompra>
			val query = criteria.createQuery(entityType)
			val from = query.from(entityType)
			query.select(from)
			generateWhere(criteria, query, from, descripcionBuscada, stockMinimoABuscar, stockMaximoABuscar,
				soloDebajoStockMinimo)
			entityManager.createQuery(query).resultList
		} finally {
			entityManager.close
		}

	}


//TODO: CREO QUE NO SE USA
//	override List<Producto> getProductos() {
//		allInstances
//	}

	override ProductoCompuesto searchById(Producto producto) {
		val entityManager = entityManager
		val id = producto.idProducto
		try {
			val criteria = entityManager.criteriaBuilder
			val query = criteria.createQuery
			val camposProducto = query.from(ProductoCompuesto)
			camposProducto.fetch("listaDeProductos")
			query.select(camposProducto)
			query.where(criteria.equal(camposProducto.get("idProducto"), id))
			val result = entityManager.createQuery(query).singleResult
			if (result === null) {
				null
			} else {
				result as ProductoCompuesto
			}
		} finally {
			entityManager.close
		}
	}

	override searchProducto(Producto producto) {
		val entityManager = entityManager
		val id = producto.idProducto
		try {
			val criteria = entityManager.criteriaBuilder
			val query = criteria.createQuery
			val camposProducto = query.from(ProductoCompuesto)
			camposProducto.fetch("listaDeProductos")
			query.select(camposProducto)
			query.where(criteria.equal(camposProducto.get("idProducto"), id))
			val result = entityManager.createQuery(query).resultList
			if (result.isEmpty) {
				null
			} else {
				result.head as ProductoCompuesto
			}
		} finally {
			entityManager.close
		}
	}
	
//		override searchProducto(Producto producto) {
//		val entityManager = entityManager
//		val id = producto.idProducto
//		try {
//			val criteria = entityManager.criteriaBuilder
//			val query = criteria.createQuery
//			val camposProducto = query.from(ProductoCompuesto)
//			camposProducto.fetch("listaDeProductos")
//			query.select(camposProducto)
//			query.where(criteria.equal(camposProducto.get("idProducto"), id))
//			val result = entityManager.createQuery(query).resultList
//			if (result.isEmpty) {
//				
//			val query2 = criteria.createQuery
//			val camposProducto2 = query2.from(Producto)
//			query2.select(camposProducto2)
//			query2.where(criteria.equal(camposProducto2.get("idProducto"), id))
//			val result2 = entityManager.createQuery(query2).resultList
//			result2.head as Producto
//			} else {
//				result.head as ProductoCompuesto
//			}
//		} finally {
//			entityManager.close
//		}
//	}

}
