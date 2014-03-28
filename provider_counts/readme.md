Workflow
==========
1) Import NBM state data

	(Download state-level shapefiles from nbm.gov)
	nbm_state_import.py

2) Set up tables in PostgreSQL

	postgres_table_prep_mar19.sql

3) Run calculations

	provider_counts_cable_public.py
	provider_counts_cable_private.py
	provider_counts_cable_library.py

4) Sum across block, address, road columns

	column_totals_mar19.sql

5) Export CSV file

	cable_provider_export_mar14.sql