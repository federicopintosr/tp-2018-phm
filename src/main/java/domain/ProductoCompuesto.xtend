package domain

import java.util.List
import javax.persistence.CascadeType
import javax.persistence.DiscriminatorValue
import javax.persistence.Entity
import javax.persistence.FetchType
import javax.persistence.OneToMany
import org.eclipse.xtend.lib.annotations.Accessors
import org.neo4j.ogm.annotation.Relationship
import org.uqbar.commons.model.annotations.Observable
import org.mongodb.morphia.annotations.Embedded

//@NodeEntity(label="ProductoCompuesto")

@Accessors
@Observable
@Entity
@DiscriminatorValue("2")
@org.mongodb.morphia.annotations.Entity (value= "Producto")


class ProductoCompuesto extends Producto {
	
	
	@OneToMany(fetch=FetchType.LAZY, cascade=CascadeType.ALL)
	@Relationship(type = "COMPUESTO_P", direction = "OUTGOING")
	@Embedded
	List<ItemProducto> listaDeProductos = newArrayList

	new() {
	}

	new(List<ItemProducto> unaListaDeProcesos) {
		listaDeProductos = unaListaDeProcesos
	}	

	override getDescripcion() {
		if (!super.descripcion.contains(" (Compuesto)")){
			super.descripcion + " (Compuesto)"
		}else {super.descripcion}
	}

	def agregarProducto(ItemProducto item) {
		listaDeProductos.add(item)
	}

	def removerProducto(ItemProducto item) {
		listaDeProductos.remove(item)
	}

	override getCosto() {
		listaDeProductos.fold(0.0, [acum, item|acum + item.costo])
	}
}
