package persistencias

import javax.persistence.DiscriminatorValue
import javax.persistence.Entity
import repositorio.neo4j.RepoOrdenCompraGrafos
import repositorio.neo4j.RepoProductoGrafos
import repositorio.neo4j.RepoProveedorGrafos

@Entity
@DiscriminatorValue("3")
class PersistenciaGrafos extends ModoPersistencia {

	new() {
		modoPersistenciaDesc = "Grafos"
		esActivo = false
	}

	override getRepositorioOrdenCompra() {
		RepoOrdenCompraGrafos.instance
	}

	override getRepositorioProductos() {
		RepoProductoGrafos.instance
	}

	override getRepositorioProveedores() {
		RepoProveedorGrafos.instance
	}
}
