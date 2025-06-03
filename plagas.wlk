//--------ELEMENTOS---------

class Hogar{
  var mugre
  const confort
  method mugre()= mugre
  method confort()= confort
  method esBueno() = confort >= mugre / 2
  method esAtacadoPor(unaPlaga){mugre += unaPlaga.danio()}
}

class Huerta{
    var produccion
    method produccion()= produccion
    method esBueno() = produccion > nivelMinimoProduccion.valor()
    method esAtacadoPor(unaPlaga){
        produccion -= 0.max((unaPlaga.danio()/10 + if(unaPlaga.transmiteEnfermedad())10 else 0))
    }
}

object nivelMinimoProduccion {
  var property valor = 100
}

class Mascota{
    var salud
    method salud()= salud
    method esBueno()= salud > 250
    method esAtacadoPor(unaPlaga){if(unaPlaga.transmiteEnfermedad())salud-=0.max(unaPlaga.danio())}
}

class Barrio{
    const elementos = []
    method agregarElemento(unElemento){elementos.add(unElemento)}
    method eliminarElemento(unElemento){elementos.remove(unElemento)}
    method esBueno(unElemento)= unElemento.esBueno()
    method esCopado() = self.elementosBuenos() > self.elementosMalos()
    method elementosBuenos()= elementos.count({e=>e.esBueno()})
    method elementosMalos()= ! elementos.count({e=>e.esBueno()})
}

//--------PLAGAS---------

class Plaga{
    var poblacion
    method transmiteEnfermedad() = poblacion >= 10 && self.condicionAdicional()
    method condicionAdicional()
    method danio() = poblacion 
    method efectosDeAtacar() {poblacion += poblacion/10}
    method atacar(unElemento){
        unElemento.esAtacadoPor(self)
        self.efectosDeAtacar()
    }
}

class Cucaracha inherits Plaga {
    var pesoPromedioBicho
    method pesoPromedioBicho()= pesoPromedioBicho
    override method danio() = super() * 0.5
    override method condicionAdicional() =  pesoPromedioBicho >= 10
    override method efectosDeAtacar(){super() and pesoPromedioBicho + 2}
    
}

class Pulgas inherits Plaga {
    override method danio() = super() * 2
    override method condicionAdicional() = true
}

class Garrapatas inherits Pulgas {
    override method efectosDeAtacar(){poblacion += poblacion/20}
}

class Mosquito inherits Plaga {
    override method condicionAdicional() = poblacion % 3 == 0
}
