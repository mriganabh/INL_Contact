Parameters changed - 
1. Mesh Block - 
	- Different mesh files for different embedment cases
2. Functions Block
	- Displacement input is changed
3. Contact Block	
	- Coefficient of friction (COF) - 0.1 or 0.4
	- Penalty reduced to 1e4 
	- For glued & frictionless models, COF is commented out
4. Postprocessor block - 
	- Additional variables are requested at nodes & points
5. Executioner block
	- nl_abs_tol = 1e-6
  	- nl_rel_tol = 1e-6
  	- l_tol = 1e-6
  	- l_max_its = 50
	-timestep_tolerance = 1e-6
6. Controls block
	- Conducted static analysis for the 1st time-step only

