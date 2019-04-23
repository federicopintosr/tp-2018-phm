package repositorio.interfaces

import domain.Proveedor
import java.util.List

interface RepoProveedor extends Repositorio<Proveedor> {

	override List<Proveedor> allInstances()

}
