package repositorio.persistencias

import java.util.List
import javax.persistence.criteria.CriteriaBuilder
import javax.persistence.criteria.CriteriaQuery
import javax.persistence.criteria.Predicate
import javax.persistence.criteria.Root
import persistencias.ModoPersistencia
import repositorio.mySQL.RepoDefault

class RepoPersistencia extends RepoDefault<ModoPersistencia> {
	
	static RepoPersistencia instance

	static def getInstance() {
		if (instance === null) {
			instance = new RepoPersistencia()
		}
		return instance
	}

	override getEntityType() {
		typeof(ModoPersistencia)
	}

	def generateWhereModosPersistenciaActivos(CriteriaBuilder criteria, CriteriaQuery<ModoPersistencia> query,
		Root<ModoPersistencia> modoPersistencia, boolean esActivo) {
		var List<Predicate> condiciones = newArrayList
		condiciones.add(criteria.equal(modoPersistencia.get("esActivo"), esActivo))
		query.where(condiciones)
	}

	def List<ModoPersistencia> getModosPersistenciaActivos() {
		val entityManager = this.entityManager
		try {
			val criteria = entityManager.criteriaBuilder
			val query = criteria.createQuery(entityType)
			val from = query.from(entityType)
			query.select(from)
			generateWhereModosPersistenciaActivos(criteria, query, from, true)
			query.orderBy(criteria.desc(from.get("fechaActivacion")))
			entityManager.createQuery(query).resultList
		} finally {
			entityManager.close
		}

	}
	
	def ModoPersistencia getUltimoModoPersistenciaActivado(){
		getModosPersistenciaActivos.head
	}

	def List<ModoPersistencia> getModosPersistenciaInactivos() {
		val entityManager = this.entityManager
		try {
			val criteria = entityManager.criteriaBuilder
			val query = criteria.createQuery(entityType)
			val from = query.from(entityType)
			query.select(from)
			generateWhereModosPersistenciaActivos(criteria, query, from, false)
			entityManager.createQuery(query).resultList
		} finally {
			entityManager.close
		}
	}

	def List<ModoPersistencia> searchByTipoPersistencia(String tipoPersistencia){
		val entityManager = this.entityManager
		try {
			val criteria = entityManager.criteriaBuilder
			val query = criteria.createQuery(entityType)
			val from = query.from(entityType)
			query.select(from)
			query.where(criteria.equal(from.get("modoPersistenciaDesc"), tipoPersistencia))
			entityManager.createQuery(query).resultList
		} finally {
			entityManager.close
		}		
	}

	def List<ModoPersistencia> searchByActivo(String tipoPersistencia){
		val entityManager = this.entityManager
		try {
			val criteria = entityManager.criteriaBuilder
			val query = criteria.createQuery(entityType)
			val from = query.from(entityType)
			query.select(from)
			var List<Predicate> condiciones = newArrayList
			condiciones.add(criteria.equal(from.get("esActivo"), true))
			condiciones.add(criteria.equal(from.get("modoPersistenciaDesc"), tipoPersistencia))
			query.where(condiciones)
			entityManager.createQuery(query).resultList
		} finally {
			entityManager.close
		}		
	}

	def createIfNew(ModoPersistencia modo){
		if (isNew(modo)){
			create(modo)
		}
	}

	def isActive(ModoPersistencia modo){
		!(searchByActivo(modo.modoPersistenciaDesc).isEmpty)
	}
	
	def isNew(ModoPersistencia modo){
		searchByTipoPersistencia(modo.modoPersistenciaDesc).isEmpty
	}
}
