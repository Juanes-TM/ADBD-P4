## ADBD-P3: Descripción modelo entidad-relación. Viveros Tajinaste S.A.

### Descripción de las entidades definidas:

- **Vivero:** Representa cada una de las sucursales de la empresa. Su clave primaria es el **ID_Vivero**. Sus atributos son: Nombre, Latitud y Longitud (georreferenciación).

- **Zona:** Representa un área específica dentro de un vivero (e.g., almacén, exterior). Su clave primaria está compuesta por **ID_Zona** y **ID_Vivero**; y su único atributo es Nombre. Es dependiente en identificación a **Vivero**.

- **Producto:** Representa los artículos que se venden. Su clave primaria es el **ID_Producto**. Sus atributos son: Nombre, Tipo y Precio_Actual (unitario).

- **Empleado:** Representa a cada trabajador. Su clave primaria es el **DNI**. Sus atributos son: Nombre y Fecha_Ingreso.

- **Puesto:** Representa el rol laboral de cada empleado. Su clave primaria es el **ID_Puesto** y su único atributo es Nombre.

- **Cliente:** Representa a los compradores de la empresa. Es una superclase que tiene una especialización: **Cliente_Plus**. Sus atributos generales son: Nombre, Email y Teléfono.

- **Cliente_Plus:** Representa a los clientes adheridos al programa de fidelización. Hereda de **Cliente**. Su clave primaria es el **DNI**. Sus atributos son: Fecha_Ingreso y Bonificador.

- **Pedido:** Representa una orden de compra realizada por un cliente. Su clave primaria es el **ID_Pedido**. Sus atributos son: Importe, Fecha y Método_Pago.

### Descripción de cada una de las relaciones definidas con sus cardinalidades:

- **Pertenece:** Relaciona la entidad **Zona** con la entidad **Vivero**, indicando la ubicación física de la zona. También refleja que **Zona** es dependiente de **Vivero** en identificación.
  * **Cardinalidad:** Un **Vivero** debe tener asignadas una o más **Zonas (1:N)** y una **Zona** pertenece exactamente a **un Vivero (1:1)**.

- **Asignado:** Relación entre **Zona** y **Empleado**, señalando en que zona está asigando un empleado, lo que indirectamente indica en que vivero esta asignado también.
  * **Cardinalidad:** Un **Empleado** es asigando a una **Zona (1:1)** y una **Zona** tiene a uno o más empleados asignados **(1:N)**.
    
- **Ocupa:** Relaciona la entidad **Empleado** con la entidad **Puesto**, indicando el rol que cumple cada empleado.
  * **Atributos:** Posee los atributos **Fecha_Inicio** y **Fecha_Fin**, que indican la fecha en la que empieza y termina de ejercer el puesto.
  * **Cardinalidad:** Un **Empleado** puede estar ocupando un solo **Puesto** a la vez **(1:1)** y un **Puesto** puede ser ocupado por uno o más **Empleados (1:N)**.

- **Tiene:** Relaciona la entidad **Producto** con la entidad **Zona**, indicando la disponibilidad del producto.
  * **Atributo:** Posee el atributo **Stock**, que indica la cantidad del producto en esa zona.
  * **Cardinalidad:** Un **Producto** puede estar asignado a una o más **Zonas (1:N)** y una **Zona** puede tener asignados uno o más **Productos (1:N)**.

- **Contiene:** Relaciona la entidad **Pedido** con la entidad **Producto**, detallando los artículos incluidos en la compra.
  * **Atributo:** Posee el atributo **Cantidad**, que indica las unidades de un producto en el pedido; y el atributo **Precio_Unitario**, que refleja el precio del producto el día del pedido.
  * **Cardinalidad:** Un **Pedido** debe contener uno o más **Productos (1:N)** y **Producto** puede estar incluido en uno o más **Pedidos (1:N)**.

- **Solicita:** Relaciona la entidad **Cliente** con la entidad **Pedido**, indicando qué cliente realizó la compra.
  * **Cardinalidad:** Un **Cliente** puede realizar uno o más **Pedidos (1:N)** y un **Pedido** es solicitado por exactamente **un Cliente (1:1)**.

- **Gestiona:** Relaciona la entidad **Empleado** con la entidad **Pedido**, identificando al responsable de la venta.
  * **Cardinalidad:** Un **Empleado** puede gestionar cero o más **Pedidos (0:N)**, ya que no todos los empleados se encargan de las ventas; y un **Pedido** es gestionado por exactamente un **Empleado (1:1)**.

### Descripción y ejemplos ilustrativos del dominio de cada uno de los atributos de las entidades y de las relaciones:

- **Vivero:**
  - **ID_Vivero:** Identificador numérico del vivero. INTEGER, ejemplo: 101.
  - **Nombre:** Nombre del vivero. VARCHAR(100), ejemplo: "Tajinaste Las Torres".
  - **Latitud:** Coordenada geográfica de latitud. DECIMAL(10, 8), ejemplo: 28.4682.
  - **Longitud:** Coordenada geográfica de longitud. DECIMAL(11, 8), ejemplo: -16.2518.
 
- **Zona:**
  - **ID_Zona:** Identificador numérico de la zona. INTEGER, ejemplo: 1.
  - **Nombre:** Nombre de la zona. VARCHAR(50), ejemplo: "Almacén", "Exterior".

- **Empleado:**
  * **DNI:** Documento de identidad del empleado. VARCHAR(10), ejemplo: "45678901Z".
  * **Nombre:** Nombre completo del empleado. VARCHAR(100), ejemplo: "Ana Pérez Gómez".
  * **Fecha_Ingreso:** Fecha de entrada en la empresa. DATE, ejemplo: 2020-05-15.

- **Puesto:**
  * **ID_Puesto:** Identificador numérico del puesto. INTEGER, ejemplo: 1.
  * **Nombre:** Nombre del puesto. VARCHAR(50), ejemplo: "Dependiente", "Jefe de Vivero".

- **Producto:**
  * **ID_Producto:** Identificador numérico del producto. INTEGER, ejemplo: 5001.
  * **Nombre:** Nombre del producto. VARCHAR(100), ejemplo: "Rosa de Pitiminí".
  * **Tipo:** Categoría del producto. VARCHAR(50), ejemplo: "Planta".
  * **Precio:** Precio unitario de cada producto. DECIMAL(10, 2), ejemplo: 12.50.

- **Pedido:**
  * **ID_Pedido:** Identificador numérico del pedido. INTEGER, ejemplo: 20250001.
  * **Importe:** Importe total del pedido. Es un atributo calculado. DECIMAL(10, 2), ejemplo: 45.90.
  * **Método_Pago:** El método con el que se paga el pedido. VARCHAR(100), ejemplo: "con tarjeta"
  * **Fecha:** Fecha en la que se realizó el pedido. DATE, ejemplo: 2025-10-08.

- **Cliente:**
  * **Nombre:** Nombre del cliente (puede ser NULL). VARCHAR(50), ejemplo: "Juan Gonzales". 
  * **Email (multivaluado):** Email(s) del cliente (puede ser NULL). VARCHAR(100), ejemplo: "Juan@algo.com, Gonzales@algo.com".
  * **Teléfono (multivaluado):** Número(s) telefónico del cliente (puede ser NULL). VARCHAR(15), ejemplo: "+34 61234578".

- **Cliente_Plus (Entidad Especializada):**
  * **DNI:** Documento de identidad del miembro del programa de fidelización. VARCHAR(10), ejemplo: "45678901Z".
  * **Fecha_Ingreso:** Fecha de alta en el programa de fidelización. DATE, ejemplo: 2024-11-01.
  * **Bonificador:** Porcentaje de bonificación en futuras compras en base a los pedidos del mes; por tanto es un atributo calculado. DECIMAL(3,1), ejemplo: "10.0" (10% de bonificación). 
    
- **Tiene (relación):**
  * **Stock:** Cantidad disponible de un producto en una zona. INTEGER, ejemplo: 50.

- **Contiene (relación):**
  * **Cantidad:** Unidades de un producto compradas en el pedido. INTEGER, ejemplo: 2.

- **Ocupa (relación):**
  * **Fecha_Inicio:** Fecha de inicio en el puesto. DATE, ejemplo: 2025-01-01.
  * **Fecha_Fin:** Fecha de fin en el puesto/zona (puede ser NULL). DATE, ejemplo: 2025-06-30.

### Restricciones semánticas:

- El atributo stock en la relación **Asigna** siempre debe ser mayor o igual a cero (Stock $\geq 0$).
- El stock de un producto en una zona no puede ser negativo.
- La fecha de inicio en un puesto no puede ser posterior a la fecha de fin.
- La fecha de ingreso de un empleado debe ser igual a la fecha de inicio en un puesto.
- Un pedido debe contener al menos un producto y cada producto debe tener cantidad > 0.
- El importe del pedido debe corresponder a la suma de los precios de los productos incluidos.
- Los métodos de pago deben pertenecer a un conjunto finito definido por la empresa.
