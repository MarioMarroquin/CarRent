# Car Rental Link Rinkeby
https://rinkeby.etherscan.io/tx/0xd2e89a6302baa78c8f93046bcb862661cd2bb141c42217a8771d0293a7db2f5b

# Contract
0x4Db5B6d3d9e663ef75BC23Cb1ea5f45dD72c14b3


# Car Rental 

Car rental es un smart contract para poder rentar vehiculos cobrando con ether. Implementamos un sistema de recompensas con Token (CARRIE) con el cual tambien sera posible rentar teniendo un minimo acumulado.





## Consideraciones

Se parte de la premisa que existen 5 carros y la renta por día es de 0.1 ether

Solo el owner del contrato podra habilitar de nuevo los vehiculos para su renta

Cada renta aporta 100000000000000000 CARRIE TOKEN

Con 500000000000000000 CARRIE TOKEN es posible rentar un vehiculo 
## Como utilizarse

Compila el contrato

Deploya el contrato y copia la dirección

Cambia los precios de los carros del 1 al 5 a los deseados





## Funciones

changeCarValue: Cambia el precio en ether del carro en el index dado

rentCar: Función payable para rentar un coche dado un index

setCarAvailable: Función para que el dueño del contrato habilite un carro nuevamente despues de ser rentado

carsAvailable: Funcion para saber si un carro esta disponible

carValue: Retorna el precio por día de la renta del carro

currentDriver: Regresa el cliente que esta utilizando el carro
# Car Rental 

Car rental es un smart contract para poder rentar vehiculos cobrando con ether. Implementamos un sistema de recompensas con Token (CARRIE) con el cual tambien sera posible rentar teniendo un minimo acumulado.





## Authors

- [@KevinDuenas](https://www.github.com/kevinduenas)
- [@MarioMarroquin](https://github.com/MarioMarroquin)

