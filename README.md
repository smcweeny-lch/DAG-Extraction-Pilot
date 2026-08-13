# README for Directed Acyclic Graph Comparison and Merging

The analysis pipeline is as follows:

1. Node equivalence mapping ```./abstraction/consensus_belmonte.csv``` and mapping agreement ```belmonte_abstraction_agreement.R```

2. ```Node_Label_merging_and_Cleaned_Graphs.Rmd``` - plots the raw and cleaned individual DAGs for TE1, TE2, Gemini, and GPT (minimal prompt)

3. ```disagreement_classification.R``` creates the reachability (transitive-closure) disagreements (plots in ```LLM-human-agreement.Rmd```). Auto-classifies cycle vs. asymmetry, creates list of edges responsible for disagreements (stored in ./disagreement_classification/[theory]_disagreement). Uses original edges to find which edges from the disagreement edges (using ```compare_graphs()```) are responsible. ```disagreement_summaries.R``` takes the human-classified errors vs. ambiguities (and trivial differences) and summarizes unique errors by encoder and ambiguities by encoder-pairs. Summary output saved in ```data/```

4. ```jaccard_closure.R``` calculates the summary statistics about disagreements. Closure-based Jaccard is best metric, but still can artificially tank agreement among pairs with a cycle because cycles have an outsize influence on reachability. Summary output saved in ```data/```


cleaning_functions.R contains all relevant functions for cleaning and analysis including:

1. loading the graphs (need to be unpacked in scripts by using ```list2env(list, envir = .GlobalEnv)```)

2. defunct path alignment analyses (get_all_paths(), align_paths(), find_best_alignment(), top_k_alignments(), extract_differences(), plot_alignment(), wrap_label_words(), wrap_label_vec(), and plot_alignment_gg().

3. Reachability (transitive-closure using binary Floyd-Warshall algorithm)