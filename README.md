<h1 align="center">MATLAB-ISS-Orbit-Propagator</h1>
<div align="center"><img width="487" height="492" alt="image" src="https://github.com/user-attachments/assets/6c73b4eb-3bc8-4415-a80b-2ba92bd38d4c" /> </div></br></br>
<h1>Overview</h1>
This project is a simulation of the International Space Station's orbit using fourth-order Runge-Kutta method under a two-body gravitational model. With the data, the program generates:
<ul> <li>A 3D visualization of the ISS orbit around a textured Earth during the selected time</li>
<li>The ground track over the Earth's surface</li>
<li>The option of generating an animation that can be exported as an MP4 video</li></ul>
<h1>The Physical Model</h1>
The current simulation assumes several conditions:
<ul><li>Assumes the Earth is a perfect sphere</li>
<li>It only takes into account the Earth's gravitational attraction</li>
<li>Atmospheric drag is neglected</li>
<li>Takes a constant Earth rotation rate (7.292*1e-5 rad/s)</li>
<li>No solar radiation pressure</li>
<li>No orbital maneuvers</li></ul>
<h1>Fourth-Order Runge-Kutta Implementation</h1>
The ISS's motion equations are integrated using the RK4 method with a fixed time step that the user can change anytime. Given the initial conditions (coordinates, altitude, azimuth angle and absolute velocity), the simulation generates a state vector that contains the position and velocity data measured from a fixed (non-rotating) frame of reference in which the X axis points to the coordinates 0º 0º at the beginning of the simulation. In every iteartion the algorithm computes the ISS's position, velocity, distance from Earth's center, coordinates and altitude. <b>It is important to note that due to the error in each iteration and the assumptions of the physical model, long-duration simulations will eventually diverge from the real ISS's orbit.</b>
<h1> Default Conditions</h1>
The default simulation parameters are:
<ul><li>Initial Altitude: 416700 m</li>
  <li> Initial Absolute Velocity: 7660 m/s</li>
  <li> Initial Latitude: 21.12 degrees</li>
  <li>Initial Longitude: -152.83 degrees</li>
  <li>Initial Azimuth Angle: 316.6 degrees</li>
  <li>Time step: 1 s</li>
  <li>ISS mass: 420000 kg</li>
  <li>Initial time: 0 s</li>
  <li>Time of simulation: 5400 s</li>
</ul>
<h1>Requirements</h1>
<li>MATLAB R2020a or later (no additional toolboxes required).</li>
<h1>How to use</h1>
<ol><li>Download the repository. Open the file ISS.m with MATLAB (you must have Earth-Surface.jpg in the same directory as the MATLAB script)</li>
<li>If required, is possible to change the parameters listed before in the inicialization part of the code</li>
<li>Run the simulation. The program will ask if it has to generate the MP4 video and its required speed</li></ol>
<h1>Outputs</h1>
With the default conditions, the program must generate the following figures: </br></br>
<div align="center"><img align= "center" width="750" height="717" alt="PORTADA README" src="https://github.com/user-attachments/assets/569eeee2-3597-49c2-b6c2-b6ef49b6aced" /> </div>
AÑADIR EL RESTO!!!!!!
<h1>Future Improvements</h1>
Future versions of the simulation will include along its improvements:
<ul>
  <li>J2 and further gravitational perturbations</li>
  <li> Real-time ISS position comparison</li>
  <li>Adaptive time step for the integrator</li>
  <li>Physical effects associated to the Moon and the Sun</li>
  <li>Atmospheric drag</li>
</ul>
<h1>References</h1>
<ul>
  <li>Curtis, H. D. Orbital Mechanics for Engineering Students</li>
  <li>MathWorks. MATLAB®. Natick, Massachusetts: The MathWorks Inc. </br>https://www.mathworks.com/products/matlab.html</li>
</ul>
<h1>License</h1>
This project is licensed under the MIT License (see more in the LICENSE file) and it is intended for educational and research purposes. Feel free to modify and improve the code!
<h1>Authors</h1>
<li>Carlos Vélez Ojeda.</li>
