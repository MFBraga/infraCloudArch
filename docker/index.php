<!DOCTYPE html>
<html lang="pt-BR">
<head>
    <meta charset="utf-8">
    <title>Mauricio Braga (AS04)</title>
    <style>
        html { color-scheme: light dark; }
        body { width: 35em; margin: 0 auto;
        font-family: Tahoma, Verdana, Arial, sans-serif; }
                h1{text-align: center;}
                h3{text-align: center;}
    </style>
</head>
<body>
    <h1>Welcome to nginx!</h1>
    <?php
        $HOSTNAME = exec('hostname 2>&1');
        echo "<h3>Hostname: $HOSTNAME</h3>";
    ?>
    <hr align="center">
    <h1>Classroom Task: <a href="https://classroom.google.com/u/0/c/NDYwMDUzMjg3NDUx/a/NDg5MDQwNTE5MzE0">KUBERNETES</a></h1>
    <hr align="center">
        <h3>MAURICIO DE FREITAS BRAGA  (RA nº. 2201495)</h3>
    <ul>
        <li>FACULDADE IMPACTA TECNOLOGIA - FIT</li>
        <li>Disciplina: Infrastructure and Cloud Architecture</li>
        <li>Professor:  João Victorino</li>
        <li>Turma:      Arquitetura de Soluções Digitais (AS_04 - 2022)</li>
    </ul>
    <hr align="center">
    <p align="center">
        <br>
        <form method="post">
            <input type="submit" name="pressed"
                    value="TEST MySQL"/>
        </form>
        <br>
    </p>
    <?php
        if(isset($_POST['pressed'])) {
            $DATE = exec('date 2>&1');
            echo "<pre>$DATE</pre>";

            echo "<pre>===============================================</pre>";
            echo "<pre>>>>>MySQL HEALTH CHECK</pre>";
            $HEALTHCHECK = exec('mysqladmin ping -h svc-mysql-nodeport.default.svc.cluster.local -u root --password=password 2>&1');
            echo "<pre>$HEALTHCHECK</pre>";
            echo "<br>";

            echo "<pre>===============================================</pre>";
            echo "<pre>>>>>MySQL QUERY</pre>";
            $QUERY = exec('mysql -h svc-mysql-nodeport.default.svc.cluster.local -u root --password=password -D impacta -e "select * from students" 2>&1');
            echo "<pre>$QUERY</pre>";
        }
    ?>
</body>
</html>