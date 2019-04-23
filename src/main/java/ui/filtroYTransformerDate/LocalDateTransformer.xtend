package ui.filtroYTransformerDate

import org.uqbar.arena.bindings.ValueTransformer
	import java.time.LocalDate
	import java.time.format.DateTimeFormatter
	import org.apache.commons.lang.StringUtils
	import org.uqbar.commons.model.exceptions.UserException
	import java.text.ParseException
	
	public final class LocalDateTransformer implements ValueTransformer<LocalDate, String> {
	    val String pattern = "dd/MM/yyyy";
	    val DateTimeFormatter formatter = DateTimeFormatter.ofPattern(pattern)
	
	    override public LocalDate viewToModel(String valueFromView) {
	        try {
	            if (StringUtils.isBlank(valueFromView))
	                return null
	            else{
	                return LocalDate.parse(valueFromView,formatter);
	            }
	
	        } catch (ParseException e) {
	   
	            throw new UserException("Debe ingresar una fecha en formato: " + this.pattern);
	        }
	    }
	
	    override String modelToView(LocalDate valueFromModel) {
	        if (valueFromModel === null) {
	            return null;
	        }
	        return valueFromModel.format(formatter)
	    }
	
	    override Class<LocalDate> getModelType() {
	        typeof(LocalDate)
	    }
	
	    override Class<String> getViewType() {
	        typeof(String)
	    }
	    
	    }