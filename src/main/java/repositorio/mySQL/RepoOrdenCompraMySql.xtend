package repositorio.mySQL

import domain.OrdenCompra
import domain.Producto
import domain.Proveedor
import java.time.LocalDate
import java.util.List
import javax.persistence.criteria.CriteriaBuilder
import javax.persistence.criteria.CriteriaQuery
import javax.persistence.criteria.JoinType
import javax.persistence.criteria.Predicate
import javax.persistence.criteria.Root
import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.commons.model.annotations.TransactionalAndObservable
import repositorio.interfaces.RepoOrdenCompra

@Accessors
@TransactionalAndObservable
class RepoOrdenCompraMySql extends RepoDefault<OrdenCompra> implements RepoOrdenCompra{

	static RepoOrdenCompraMySql instance

	static def getInstance() {
		if (instance === null) {
			instance = new RepoOrdenCompraMySql()
		}
		return instance
	}

	override getEntityType() {
		typeof(OrdenCompra)
	}

	def generateWhere(CriteriaBuilder criteria, CriteriaQuery<OrdenCompra> query, Root<OrdenCompra> ordenDeCompra,
		Producto productoBuscado, Proveedor proveedorBuscado, Double costoMinABuscar, Double costoMaxABuscar,
		LocalDate fechaMinABuscar, LocalDate fechaMaxABuscar) {

		var List<Predicate> condiciones = newArrayList
		if (proveedorBuscado !== null) {
			condiciones.add(criteria.equal(ordenDeCompra.get("proveedor"), proveedorBuscado))
		}
		if (productoBuscado !== null) {
			val joinProducto = ordenDeCompra.joinList("listaDeProductos", JoinType.LEFT)
			condiciones.add(criteria.equal(joinProducto.get("producto"), productoBuscado.idProducto))
		}
		if (costoMaxABuscar !== null) {
			condiciones.add(criteria.lt(ordenDeCompra.get("costoFinal"), costoMaxABuscar))
		}
		if (costoMinABuscar !== null) {
			condiciones.add(criteria.gt(ordenDeCompra.get("costoFinal"), costoMinABuscar))
		}
		if (fechaMaxABuscar !== null) {
			condiciones.add(criteria.lessThan(ordenDeCompra.get("fecha"), fechaMaxABuscar))
		}
		if (fechaMinABuscar !== null) {
			condiciones.add(criteria.greaterThan(ordenDeCompra.get("fecha"), fechaMinABuscar))
		}
		query.where(condiciones)
	}

	override List<OrdenCompra> search(Producto productoBuscado, Proveedor proveedorBuscado, Double costoMinABuscar,
		Double costoMaxABuscar, LocalDate fechaMinABuscar, LocalDate fechaMaxABuscar) {
		val entityManager = this.entityManager
		try {
			val criteria = entityManager.criteriaBuilder
			val query = criteria.createQuery(entityType)
			val from = query.from(entityType)
			query.select(from)
			generateWhere(criteria, query, from, productoBuscado, proveedorBuscado, costoMinABuscar, costoMaxABuscar,
				fechaMinABuscar, fechaMaxABuscar)
			val result=entityManager.createQuery(query).resultList as List<OrdenCompra>
			result.forEach[oc|oc.costo]
			result
		} finally {
			entityManager.close
		}

	}

}
