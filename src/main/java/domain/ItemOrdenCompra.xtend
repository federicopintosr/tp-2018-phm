package domain

import javax.persistence.Column
import javax.persistence.Entity
import javax.persistence.GeneratedValue
import javax.persistence.Id
import javax.persistence.OneToOne
import org.eclipse.xtend.lib.annotations.Accessors
import org.neo4j.ogm.annotation.NodeEntity
import org.neo4j.ogm.annotation.Property
import org.neo4j.ogm.annotation.Relationship
import org.uqbar.commons.model.annotations.Observable
import org.bson.types.ObjectId

@NodeEntity(label="ItemOrdenCompra")
@org.mongodb.morphia.annotations.Entity
@Observable
@Accessors
@Entity
class ItemOrdenCompra {
	@Id
	@GeneratedValue
	private Long idItemOrdenCompra
	
	@org.neo4j.ogm.annotation.Id
	@org.neo4j.ogm.annotation.GeneratedValue
	private Long idItemOrdenCompraNeo4J
	
	@org.mongodb.morphia.annotations.Id
	ObjectId idItemOrdenCompraMongo

	@Property(name="cantidad")
	@Column
	int cantidad
	
	@Relationship(type = "CANTIDAD_DE", direction = "OUTGOING")
	@OneToOne
	Producto producto

	def costo() {
		producto.costo * cantidad

	}

	def descripcion() {
		cantidad + " " + producto.descripcion
	}
}
