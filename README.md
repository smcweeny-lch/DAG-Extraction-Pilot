# README for Formalization of Causal Theories of Autism as Directed Graphs Using Experts and Large Language Models

The overall structure of this research was as follows (see Figure 1): 

1. Human experts and LLMs independently encode three theories on the development of core features of autism as directed graphs. .json tuple representations of these graphs are stored in ```Json/```. The engineered (given to "engineered LLMs") and minimal prompts (given to humans and "minimal prompt LLMs") are stored in ```code/prompts/```

2. Human experts rated these according to the rubric in ```materials/rubric/rubric_graphs_1_20_2026.docx```. The ratings are in ```data/ratings.xlsx```.

3. Node equivalence maps, which map the idiosyncratic encoder names (e.g., "low joint attention") to umbrella categories (e.g., JOINT_ATTENTION) are presented in ```/abstraction/```. The simplified ```node_map```, which removes the original encoder for each term, as well as the more full consensus code ```abstraction/consensus_belmonte.csv``` and so on for Baron-Cohen and Gepner. To plots the raw and cleaned individual DAGs for TE1, TE2, Gemini, and GPT (minimal prompt), paste the corresponding HTML from ```Node_Label_merging_and_Cleaned_Graphs.Rmd``` into an HTML viewer (not supported by GitHub).  

4. ```disagreement_classification.R``` creates the reachability (transitive-closure) disagreements (plots in ```LLM-human-agreement.Rmd```). Auto-classifies cycle vs. asymmetry, creates list of edges responsible for disagreements (stored in ./disagreement_classification/[theory]_disagreement). Uses original edges to find which edges from the disagreement edges (using ```compare_graphs()```) are responsible. ```disagreement_summaries.R``` takes the human-classified errors vs. ambiguities (and trivial differences) and summarizes unique errors by encoder and ambiguities by encoder-pairs. Summary output saved in ```data/```. ```disagreement_summaries.R``` also outputs commission/omission errors to ```./disagreement_classification/commission_errors_to_drop.csv``` and ```/disagreement_classification/omission_errors_to_add.csv```. ```jaccard_closure.R``` calculates the summary statistics about disagreements. Closure-based Jaccard is best metric, but still can artificially tank agreement among pairs with a cycle because cycles have an outsize influence on reachability. Summary output saved in ```data/```.  

5. ```code/updated_subgraphs_after_error_handling.R``` takes the identified errors and drops/adds them to each encoder's original graph. So far, only done for human pairs. Needs to solve plotting cycles for publication. 

#### Other notes: 

```cleaning_functions.R``` contains all relevant functions for cleaning and analysis including:

1. loading the graphs (need to be unpacked in scripts by using ```list2env(list, envir = .GlobalEnv)```)

2. defunct path alignment analyses (get_all_paths(), align_paths(), find_best_alignment(), top_k_alignments(), extract_differences(), plot_alignment(), wrap_label_words(), wrap_label_vec(), and plot_alignment_gg().

3. Reachability (transitive-closure using binary Floyd-Warshall algorithm)