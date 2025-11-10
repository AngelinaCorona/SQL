/* Explorar la tabla “menu_items” para conocer los productos del menú */

Select * 
from menu_items
;

-- Encontrar el numero de articulos en el menú
-- Respuesta: 32

select count (menu_item_id)
from menu_items
;

-- ¿Cuál es el artículo menos caro y el más caro en el menú?
-- Menos caro: Edamame
-- Mas caro: Shrimp Scampi

select max (price), item_name
from menu_items
group by item_name
order by max (price) asc
;

-- ¿Cuántos platos americanos hay en el menú?
-- Respuesta: 6

select count (category), category
from menu_items
group by category
;

-- ¿Cuál es el precio promedio de los platos?
-- Respuesta: 13.28

select avg (price) as Precio_Promedio_de_los_Platos
from menu_items
;

/*Explorar la tabla “order_details” para conocer los datos que han sido recolectados */

Select * 
from order_details
;

-- ¿Cuántos pedidos únicos se realizaron en total?
-- Respuesta: 5,370

select count(distinct order_id) as Total_Pedidos_Unicos
from order_details
;

-- ¿Cuáles son los 5 pedidos que tuvieron el mayor número de artículos?
-- Respuesta Pedido 4305, 3473, 2675, 443 y 440 con 14 articulos.

select order_id, count(item_id) as total_articulos
from order_details
group by order_id
order by total_articulos desc
limit 5
;

-- ¿Cuándo se realizó el primer pedido y el último pedido?
-- Primer pedido: 2023-01-01
-- Ultimo pedido: 2023-03-31

select distinct order_date as primer_pedido
from order_details
order by order_date asc
limit 1
;

select distinct order_date as pltimo_pedido
from order_details
order by order_date desc
limit 1
;
 --otra opcion mas corta y directa
select
MIN(order_date) as primer_pedido,
MAX(order_date) as ultimo_pedido
from order_details
;

-- ¿Cuántos pedidos se hicieron entre el '2023-01-01' y el '2023-01-05'?
-- Respuesta: 308
select count(distinct order_id) as total_pedidos
from order_details
where order_date between '2023-01-01' and '2023-01-05'
;


/* Usar ambas tablas para conocer la reacción de los clientes respecto al menú */

select
od.order_id, od.order_date, mi.item_name, mi.category, mi.price
from order_details as od
left join menu_items as mi
on od.item_id = mi.menu_item_id
;

-- Realizar un left join entre entre order_details y menu_items con el identificador: item_id(tabla order_details) y menu_item_id(tabla menu_items).

select mi.category,
count(od.order_details_id) as platillo_total_vendido
from order_details as od
left join menu_items as mi
on od.item_id = mi.menu_item_id
group by 1
order by platillo_total_vendido desc
;

/* Una vez que hayas explorado los datos en las tablas correspondientes y respondido las
preguntas planteadas, realiza un análisis adicional utilizando este join entre las tablas. El
objetivo es identificar 5 puntos clave que puedan ser de utilidad para los dueños del
restaurante en el lanzamiento de su nuevo menú. Para ello, crea tus propias consultas y
utiliza los resultados obtenidos para llegar a estas conclusiones */

-- Punto 1. cual es la categoria de comida que mas se vende y optar por tener mas platillos de esa categoria o bien, buscar mejorar la que menos se venda.

select mi.category, sum(mi.price) as ingresos_totales
from order_details as od
left join menu_items as mi
on od.item_id = mi.menu_item_id
group by mi.category
order by ingresos_totales desc
;

-- Punto 2. cual es el platillo best seller. con esto se puede asegurar de mantenerlo en el menu y cuidar la calidad del producto

select mi.item_name, count(od.order_details_id) as cantidad_vendida
from order_details as od
left join menu_items as mi
on od.item_id = mi.menu_item_id
group by mi.item_name
order by cantidad_vendida desc
limit 1
;

-- Punto 3. cual es el platillo worst seller. con esto se puede considerar buscar una mejora en el mismo o bien eliminarlo del nuevo menu

select mi.item_name, count(od.order_details_id) as cantidad_vendida
from order_details as od
left join menu_items as mi
on od.item_id = mi.menu_item_id
group by mi.item_name
order by cantidad_vendida asc
limit 1
;

-- Punto 4. Cual platillo genera mas ingresos
select mi.item_name,
sum(mi.price) as ingresos_totales
from order_details as od
left join menu_items as mi 
on od.item_id = mi.menu_item_id
group by mi.item_name
order by ingresos_totales desc
;


