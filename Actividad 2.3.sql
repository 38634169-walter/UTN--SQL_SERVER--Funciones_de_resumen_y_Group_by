GO 
USE Larabox


--1
SELECT COUNT(a.ID) AS [Cantidad Archivos] FROM Archivos AS a
WHERE a.IDUsuario = 5;

--2
SELECT COUNT(Extension) AS Extension FROM Archivos
WHERE Extension = 'AVI'

--3
SELECT COUNT(dp.Telefono) FROM Usuarios AS u
INNER JOIN DatosPersonales AS dp ON dp.ID = u.ID
WHERE dp.Telefono IS NOT NULL;

--4
SELECT COUNT(DISTINCT u.ID)  AS Extension FROM Usuarios AS u
INNER JOIN Archivos AS a ON a.IDUsuario = u.ID
WHERE Extension = 'AVI';

--5
SELECT AVG(a.Tamaño) FROM Archivos AS a
WHERE Extension IN('mp3');

--6
SELECT SUM(p.Importe) FROM Pagos AS p
WHERE MONTH(p.Fecha) = 10 AND YEAR(p.Fecha) = 2020;

--7
SELECT COUNT(u.ID) FROM Usuarios AS u
INNER JOIN DatosPersonales AS dp ON dp.ID = u.ID 
INNER JOIN Localidades AS l ON l.ID = dp.IDLocalidad
INNER JOIN Paises AS p ON l.IDPais = p.ID
WHERE p.Nombre = 'Argentina';

--8
SELECT dp.Nombres, dp.Apellidos, COUNT(a.ID) AS [Archivos subidos]FROM DatosPersonales AS dp
INNER JOIN Usuarios AS u ON dp.ID = u.ID
INNER JOIN Archivos AS a ON u.ID=a.IDUsuario
GROUP BY dp.Nombres, dp.Apellidos;

--9
SELECT a.Extension, COUNT(a.Extension) as [Cantidad archivos], SUM(A.Tamaño/1024.0) AS [acumulacion MB] 
FROM Archivos AS a
GROUP BY a.Extension;

--10
SELECT fp.Nombre AS [Forma pago], AVG(p.Importe) AS [Promedio abonado] FROM Pagos AS p
INNER JOIN FormasPago AS fp ON fp.ID=p.IDFormaPago
GROUP BY fp.Nombre

--11
SELECT fp.Nombre, SUM(p.Importe) AS PagoIMP FROM FormasPago AS fp
INNER JOIN Pagos AS p ON p.IDFormaPago = fp.ID
GROUP BY fp.Nombre
HAVING SUM(p.Importe)>4000;

--12
GO
SELECT dp.Nombres,dp.Apellidos,isnull(SUM(p.Importe),0) FROM Usuarios AS u
INNER JOIN DatosPersonales AS dp ON dp.ID=U.ID
INNER JOIN Suscripciones AS s ON s.IDUsuario=u.ID
LEFT JOIN Pagos AS p ON p.IDSuscripcion =s.ID
GROUP BY dp.Nombres, dp.Apellidos;

--13
SELECT a.Extension, MAX(a.Tamaño)/1024.0 AS [Maximo tamaño de archivo en MB] FROM Archivos AS a
GROUP BY a.Extension;

--14
SELECT YEAR(p.Fecha), COUNT(p.ID) FROM Pagos AS p 
GROUP BY YEAR(p.Fecha);

--15
SELECT tc.Nombre, COUNT(p.ID) FROM TiposCuenta AS tc
INNER JOIN Suscripciones AS s ON s.IDTipoCuenta = tc.ID
INNER JOIN Pagos AS p ON p.IDSuscripcion = s.ID
GROUP BY tc.Nombre;

--16
SELECT u.Nombreusuario, dp.Nombres, dp.Apellidos,a.Extension, COUNT(a.Extension) AS [Cantidad de archivos] FROM DatosPersonales AS dp
INNER JOIN Usuarios AS u ON dp.ID = u.ID
INNER JOIN Archivos AS a ON a.IDUsuario = u.ID
GROUP BY u.Nombreusuario, a.Extension,dp.Nombres, dp.Apellidos
HAVING COUNT(a.Extension) > 2;

--17
SELECT dp.Nombres, dp.Apellidos, COUNT(a.Extension) AS [Cantidad de extensiones] 
FROM DatosPersonales AS dp
INNER JOIN Usuarios AS u ON dp.ID = u.ID
INNER JOIN Archivos AS a ON a.IDUsuario = u.ID
GROUP BY dp.Nombres, dp.Apellidos
HAVING COUNT(a.Extension) > 5;

--18
SELECT dp.Nombres,dp.Apellidos,SUM(a.Tamaño/1024.0) AS [Total MB] FROM DatosPersonales AS dp
INNER JOIN Usuarios AS u ON u.ID = dp.ID
INNER JOIN Archivos AS a ON a.IDUsuario = u.ID
WHERE a.Estado <> 0
GROUP BY dp.Nombres, dp.Apellidos;

--19
SELECT u.Nombreusuario, 
CASE 
WHEN s.Fin IS NULL 
THEN MAX(DATEDIFF(DAY,s.Inicio,GETDATE()))
ELSE MAX(DATEDIFF(DAY,s.Inicio,s.Fin)) 
END AS Diferencia
FROM Usuarios AS u
INNER JOIN Suscripciones AS s ON s.IDUsuario=u.ID
GROUP BY u.Nombreusuario, s.Fin;

--20
SELECT dp.Nombres, dp.Apellidos, COUNT(s.ID) AS [Cantidad de suscripciones] 
FROM DatosPersonales AS dp
INNER JOIN Usuarios AS u ON u.ID = dp.ID
INNER JOIN Suscripciones AS s ON s.IDUsuario = u.ID
GROUP BY dp.Nombres, dp.Apellidos
ORDER BY COUNT(s.ID) DESC;