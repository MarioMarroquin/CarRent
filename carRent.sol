// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.0;

import "https://raw.githubusercontent.com/OpenZeppelin/openzeppelin-contracts/master/contracts/token/ERC20/extensions/ERC20Burnable.sol";

contract carRent is ERC20Burnable {
    
 
    address ownerAddress;   // Dirección del creador SC
    address driverAddress;  // Dirección del rentador
    
    struct car {
        uint valueWei;      // Valor del carro
        address carDriver;  // Dirección de rentador usando carro
        bool isAvailable;   // Booleano para saber si el carro esta disponible
    }
    
    car[5] carDB;

    // Modifiers -- prerequisito para las funciones
    modifier ownerOnly() {
        require(msg.sender == ownerAddress, "Necesitas ser Owner");
        _;
    }
    
    modifier driverOnly() {
        require(msg.sender != ownerAddress, "Si eres owner, no puedes rentar");
        _;
    }

    
    // Eventos para las funciones
    event carRented(string _msg, uint _car, address _address);
    event cantRent(string _msg, uint _car, address _address);
    event discount(string _msg, address _address);
    
    // Se crea el contrato y nuestra moneda TOKEN
    constructor()  ERC20("Carrie Coin", "CARRIE")  {
       
        ownerAddress = msg.sender;
        
        // Se inicializan todos los carros a disponibles
        // y el precio es default por 0.1 ether. 
        // Valor total de carros default a 5.
        for (uint i = 0; i < 5; i++) { 
            carDB[i].isAvailable = true;
            carDB[i].valueWei = 0.1 ether;
        }
        
    }

    // Funciones para revisar info del carro
    function carIsAvailable(uint _car) view public returns (bool) {
        return carDB[_car - 1].isAvailable;
    }
    
    function carValue(uint _car) view public returns (uint) {
        return carDB[_car - 1].valueWei;
    }
    
    function currentDriver(uint _car) view public returns (address) {
        return carDB[_car - 1].carDriver;
    }
    
 
    // Funcion solo para owner para cambiar un carro a disponible.
    function setCarAvailable(uint _car, bool _newChange) ownerOnly public {
        carDB[_car - 1].isAvailable = _newChange;
        
        if (_newChange) {
            carDB[_car - 1].carDriver = address(0);
        }
    }
    
    // Funcion solo para owner para cambiar el precio de un auto.
    function changeCarValue(uint _car, uint _value) ownerOnly public {
        carDB[_car - 1].valueWei = _value;
    }
    
    // Owner no puede rentar sus propios carros.
    // El rentador solo puede rentar por un día...
    // si da más, se le regresa el cambio.
    function rentCar(uint _car) driverOnly public payable returns (uint) {
        driverAddress = msg.sender;
        uint256 currToken = balanceOf(driverAddress);
        
        if (currToken == 500000000000000000 && carDB[_car - 1].isAvailable == true) {
            _burn(driverAddress, 500000000000000000);
        
            carDB[_car - 1].isAvailable = false;
            carDB[_car - 1].carDriver = driverAddress;
            payable(driverAddress).transfer(msg.value);

            emit discount("Se aplico descuento.", driverAddress);
            emit carRented("El carro se ha rentado", _car, driverAddress);

            return 1;
            
        } else if (msg.value >= carDB[_car - 1].valueWei && carDB[_car - 1].isAvailable == true) {
            // Si el ether es exacto, se renta
            // Si el ether es más, se regresa el sobrante.
            if (msg.value == carDB[_car - 1].valueWei) {
                carDB[_car - 1].isAvailable = false;
                carDB[_car - 1].carDriver = driverAddress;
                payable(ownerAddress).transfer(msg.value);
                _mint(driverAddress, 100000000000000000);
                emit carRented("El carro se ha rentado", _car, driverAddress);

                return 1;
            } else {
                uint256 etherSobra = msg.value - carDB[_car - 1].valueWei;
                uint256 corrPrice = msg.value - etherSobra;
                carDB[_car - 1].isAvailable = false;
                carDB[_car - 1].carDriver = driverAddress;
                payable(ownerAddress).transfer(corrPrice);
                payable(driverAddress).transfer(etherSobra);
                _mint(driverAddress, 100000000000000000);
                 emit carRented("El carro se ha rentado", _car, driverAddress);
            
                return 1;

            }
        } else {
            payable(driverAddress).transfer(msg.value);
            emit cantRent("No completas", _car, driverAddress);
            return 0;
        }
    }
    
    //limitaciones : No podemos pedir la cantidad de carros
    //              en el deploy ni tampoco modificar despues
    //              de deployar el array de carros
}