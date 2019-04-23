package domain

import java.time.LocalDate
import java.util.List
import javax.persistence.CascadeType
import javax.persistence.Column
import javax.persistence.Entity
import javax.persistence.FetchType
import javax.persistence.GeneratedValue
import javax.persistence.Id
import javax.persistence.ManyToOne
import javax.persistence.OneToMany
import org.bson.types.ObjectId
import org.eclipse.xtend.lib.annotations.Accessors
import org.mongodb.morphia.annotations.Embedded
import org.neo4j.ogm.annotation.NodeEntity
import org.neo4j.ogm.annotation.Property
import org.neo4j.ogm.annotation.Relationship
import org.uqbar.commons.model.annotations.Observable
import org.uqbar.commons.model.exceptions.UserException

@NodeEntity(label="OrdenCompra")
@Entity
@Observable
@Accessors
@org.mongodb.morphia.annotations.Entity

class OrdenCompra extends org.uqbar.commons.model.Entity {

	@Id
	@GeneratedValue
	private Long idOrdenCompra
	
	@org.neo4j.ogm.annotation.Id
	@org.neo4j.ogm.annotation.GeneratedValue
	private Long idOrdenCompraNeo4J
	
	@org.mongodb.morphia.annotations.Id
	ObjectId idOrdenCompraMongo

	@Property(name="fecha")
	@Column
	LocalDate fecha
	

	@Relationship(type = "PROVEE", direction = "OUTGOING")
	@ManyToOne
	@Embedded
	Proveedor proveedor
	
	@Relationship(type = "COMPUESTA_POR", direction = "OUTGOING")
	@OneToMany(fetch=FetchType.EAGER, cascade=CascadeType.ALL)
	@Embedded
	List<ItemOrdenCompra> listaDeProductos = newArrayList

	@Property(name="costoFinal")
	@Column
	var Double costoFinal

	def agregarProducto(ItemOrdenCompra item) {
		listaDeProductos.add(item)
	}

	def getCosto() {
		costoFinal = listaDeProductos.fold(0.0, [acum, item|acum + item.costo])

	}

	def validarFecha() {
		if (fechaSuperiorALaActual) {
			throw new UserException("La Fecha no puede ser superior a la de hoy")
		}
	}

	def fechaSuperiorALaActual() {
		fecha > LocalDate.now
	}

	def getListaDescripciones() {
		listaDeProductos.fold("",[acum,producto|acum + producto.descripcion + "; "])
	}

	def getListaProductos() {
		listaDeProductos.map[item|item.producto]
	}
	def getListaNombreProductos(){
		getListaProductos.map(producto | producto.descripcion)
	}
}
