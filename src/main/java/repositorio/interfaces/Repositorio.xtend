package repositorio.interfaces

import java.util.List

interface Repositorio<T> {
	
	def void create (T t)
	
	def void update (T t)
	
	def List<T>allInstances()
	
}
