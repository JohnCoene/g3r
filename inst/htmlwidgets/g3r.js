HTMLWidgets.widget({

  name: 'g3r',

  type: 'output',

  factory: function(el, width, height) {

    var renderer,
        canvas,
        parent,
        camera,
        radius,
        origin,
        controls,
        resizeCanvasToDisplaySize;

    return {

      renderValue: function(x) {

        parent = document.getElementById(el.id);
        canvas = document.getElementById(el.id + '-canvas');
        camera = new THREE.PerspectiveCamera(75, canvas.width/canvas.height, 0.1, 1000);
        camera.position.set(x.camera.lon, x.camera.elevation, x.camera.lat);
        camera.up.set(0, 4, 0); // important for OrbitControls
        renderer = new THREE.WebGLRenderer({
            alpha: x.alpha,
            canvas: canvas,
        });
        
        controls = new THREE.OrbitControls(camera, renderer.domElement);

        resizeCanvasToDisplaySize = (force=false) => {
          let width = parent.clientWidth;
          let height = parent.clientHeight;
          // adjust displayBuffer size to match
          if (force || parent.width != width || parent.height != height) {
            // you must pass false here or three.js sadly fights the browser
            // console.log "resizing: #{canvas.width} #{canvas.height} -> #{width} #{height}"
            renderer.setSize(width, height, false);
            camera.aspect = width / height;
            camera.updateProjectionMatrix();
          }
        };

        // object stuff --------
        var scene = new THREE.Scene();
        var walls = new THREE.LineSegments(
            new THREE.EdgesGeometry(new THREE.BoxBufferGeometry(1, 1, 1)),
            new THREE.LineBasicMaterial({color: 0xcccccc}));
        walls.position.set(0, 0, 0);
        if(x.walls)
        scene.add(walls);
        if(x.axes)
          scene.add(new THREE.AxesHelper(1));

        // render stuff --------
        var render = () => {
            renderer.render(scene, camera);
        };

        origin = [x.lat, x.lon];
        radius = x.radius;

        // main --------
        render(); // first time
        controls.addEventListener('change', render);
        var tgeo = new ThreeGeo(x.threegeo);
        tgeo.getTerrain(origin, radius, x.zoom, {
          onRgbDem: (meshes) => {},
          onSatelliteMat: (mesh) => {
              mesh.rotation.x = - Math.PI/2;
              //mesh.material.wireframe = true;
              scene.add(mesh);
              render();
          },
        });

        // add a point
        const {proj, unitsPerMeter} = tgeo.getProjection([x.lat, x.lon], x.radius);

        // proj: lng, lat -> x, y
        // const [x, y, z] = [...proj([origin[1], origin[0]]), 4000]; // reprojection test
        if(x.points){
          x.points.forEach(function(p){

            var color = new THREE.Color(p.color);

            const dot = new THREE.Points(
              new THREE.Geometry(),
              new THREE.PointsMaterial({
                  size: 8,
                  sizeAttenuation: false,
                  color: color,
              }));

            var [x, y, z] = [...proj(p.coordinates), p.elevation]; 

            dot.geometry.vertices.push(new THREE.Vector3(
                x, z * unitsPerMeter, y));
            scene.add(dot);
          })
        }

        resizeCanvasToDisplaySize(true); // first time
        renderer.setClearColor( x.backgroundColor, x.backgroundAlpha);
      },

      resize: function(width, height) {
        resizeCanvasToDisplaySize(true)
      }

    };
  }
});