# load data call (8-11-2026)
load.graphs <- function(theory, node_mapping = "consensus"){
  setwd("C:/Users/smcweeny/OneDrive - Lurie Childrens/LLM/Babak_project/Json")
  
  if(theory == "Belmonte"){
    if(node_mapping == "consensus"){
      consensus <- read.csv("../abstraction/consensus_Belmonte.csv") %>% filter(!consensus == "") %>% 
        select(original, consensus) %>% 
        distinct()
      node_map <- consensus$consensus
      names(node_map) <- consensus$original
    } else if(node_mapping == "JE"){
      source("../code/Belmonte_node_map_JE.R")
    } else if(node_mapping == "SM"){
      source("../code/Belmonte_node_equivalence.R")
    } 
    
    s <- fromJSON("./Sean/Belmonte_2004_directed_graph/output.json")
    j <- fromJSON("./Josh/Belmonte/output.json")
    gpt <- fromJSON("./Basic prompt GPT 5.2/belmonte_2004/trimmed.json")
    gemini <- fromJSON("./Basic prompt Gemini3 - fast/belmonte_2004/output.json")
    
    s <- data.frame(from = s[,1], to = s[,3])
    j <- data.frame(from = j[,1], to = j[,3])
    gpt <- data.frame(from = gpt[,1], to = gpt[,3])
    gemini <- data.frame(from = gemini[,1], to = gemini[,3])
    
    s.raw <- graph_from_data_frame(s)
    j.raw <- graph_from_data_frame(j)
    gpt.raw <- graph_from_data_frame(gpt)
    gemini.raw <- graph_from_data_frame(gemini)
    
    s.clean <- s %>% mutate(from = dplyr::recode(from, !!!node_map), to   = dplyr::recode(to, !!!node_map))
    j.clean <- j %>% mutate(from = recode(from, !!!node_map), to   = recode(to, !!!node_map))
    gpt.clean <- gpt %>% mutate(from = recode(from, !!!node_map),to   = recode(to, !!!node_map))
    gemini.clean <- gemini %>% mutate(from = recode(from, !!!node_map), to   = recode(to, !!!node_map))
    
    s.graph <- graph_from_data_frame(s.clean)
    j.graph <- graph_from_data_frame(j.clean)
    gpt.graph <- graph_from_data_frame(gpt.clean)
    gemini.graph <- graph_from_data_frame(gemini.clean)
    
  }  else if(theory == "Baron-Cohen"){
    if(node_mapping == "consensus"){
      consensus <- read.csv("../abstraction/consensus_BaronCohen.csv") %>% filter(!consensus == "") %>% 
        select(original, consensus) %>% 
        distinct()
      node_map <- consensus$consensus
      names(node_map) <- consensus$original
    } else if(node_mapping == "JE"){
      source("../code/BaronCohen_node_map_JE.R")
    } else if(node_mapping == "SM"){
      source("../code/BaronCohen_node_equivalence.R")
    } 
    
    s <- fromJSON("./Sean/BaronCohen_2002_SM_Graph/output.json")
    j <- fromJSON("./Josh/Baron-Cohen/output.json")
    gpt <- fromJSON("./Basic prompt GPT 5.2/Baron-Cohen - 2002 - The extreme male brain theory of autism/basic.json")
    gemini <- fromJSON("./Basic prompt Gemini3 - fast/Baron-Cohen - 2002 - The extreme male brain theory of autism/output.json")
    
    s <- data.frame(from = s[,1], to = s[,3])
    j <- data.frame(from = j[,1], to = j[,3])
    gpt <- data.frame(from = gpt[,1], to = gpt[,3])
    gemini <- data.frame(from = gemini[,1], to = gemini[,3])
    
    s.raw <- graph_from_data_frame(s)
    j.raw <- graph_from_data_frame(j)
    gpt.raw <- graph_from_data_frame(gpt)
    gemini.raw <- graph_from_data_frame(gemini)
    
    s.clean <- s %>% mutate(from = dplyr::recode(from, !!!node_map), to   = dplyr::recode(to, !!!node_map))
    j.clean <- j %>% mutate(from = recode(from, !!!node_map), to   = recode(to, !!!node_map))
    gpt.clean <- gpt %>% mutate(from = recode(from, !!!node_map),to   = recode(to, !!!node_map))
    gemini.clean <- gemini %>% mutate(from = recode(from, !!!node_map), to   = recode(to, !!!node_map))
    
    s.graph <- graph_from_data_frame(s.clean)
    j.graph <- graph_from_data_frame(j.clean)
    gpt.graph <- graph_from_data_frame(gpt.clean)
    gemini.graph <- graph_from_data_frame(gemini.clean)
    
  } else if(theory == "Gepner"){
    
    if(node_mapping == "consensus"){
      consensus <- read.csv("../abstraction/consensus_Gepner.csv") %>% filter(!consensus == "") %>% 
        select(original, consensus) %>% 
        distinct()
      node_map <- consensus$consensus
      names(node_map) <- consensus$original
    } else if(node_mapping == "JE"){
      source("../code/Gepner_node_map_JE.R")
    } else if(node_mapping == "SM"){
      source("../code/Gepner_node_equivalence.R")
    } 
    
    
    j <- fromJSON("./Josh/Gepner & Feron/output.json")
    s <- fromJSON("./Sean/Gepner_Feron_2009_causal_graph/output.json")
    gemini <- fromJSON("./Basic prompt Gemini3 - fast/Gepner_2009/output.json")
    gpt <- fromJSON("./Basic prompt GPT 5.2/Gepner_2009/basic.json")
    
    s <- data.frame(from = s[,1], to = s[,3])
    j <- data.frame(from = j[,1], to = j[,3])
    gemini <- data.frame(from = gemini[,1], to = gemini[,3])
    gpt <- data.frame(from = gpt[,1], to = gpt[,3])
    
    s.raw <- graph_from_data_frame(s)
    j.raw <- graph_from_data_frame(j)
    gpt.raw <- graph_from_data_frame(gpt)
    gemini.raw <- graph_from_data_frame(gemini)
    
    s.clean <- s %>% mutate(from = dplyr::recode(from, !!!node_map), to   = dplyr::recode(to, !!!node_map))
    j.clean <- j %>% mutate(from = recode(from, !!!node_map), to   = recode(to, !!!node_map))
    gpt.clean <- gpt %>% mutate(from = recode(from, !!!node_map),to   = recode(to, !!!node_map))
    gemini.clean <- gemini %>% mutate(from = recode(from, !!!node_map), to   = recode(to, !!!node_map))
    
    s.graph <- graph_from_data_frame(s.clean)
    j.graph <- graph_from_data_frame(j.clean)
    gpt.graph <- graph_from_data_frame(gpt.clean)
    gemini.graph <- graph_from_data_frame(gemini.clean)
    
  }
  return(list(j = j, s = s, gemini = gemini, gpt = gpt,
              j.raw = j.raw, s.raw = s.raw, gemini.raw = gemini.raw, gpt.raw = gpt.raw,
              j.clean = j.clean, s.clean = s.clean, gemini.clean = gemini.clean, gpt.clean = gpt.clean,
              j.graph = j.graph, s.graph = s.graph, gemini.graph = gemini.graph, gpt.graph = gpt.graph,
              node_map = node_map))
  
}



# alignment functions
get_all_paths <- function(g, max_depth = 15) {
  
  sources <- V(g)[degree(g, mode = "in") == 0]
  sinks   <- V(g)[degree(g, mode = "out") == 0]
  
  all_paths <- list()
  
  for (s in sources) {
    for (t in sinks) {
      paths <- all_simple_paths(g, from = s, to = t, cutoff = max_depth)
      
      for (p in paths) {
        all_paths <- append(all_paths, list(V(g)[p]$name))
      }
    }
  }
  
  all_paths
}
align_paths <- function(p1, p2, match_score = 2, mismatch = -1, gap = -1) {
  
  # enforce clean types
  p1 <- as.character(p1)
  p2 <- as.character(p2)
  
  n <- length(p1)
  m <- length(p2)
  
  score <- matrix(0, n+1, m+1)
  
  # Initialize
  for (i in 2:(n+1)) score[i,1] <- score[i-1,1] + gap
  for (j in 2:(m+1)) score[1,j] <- score[1,j-1] + gap
  
  # Fill matrix
  for (i in 2:(n+1)) {
    for (j in 2:(m+1)) {
      
      if (p1[i-1] == p2[j-1]) {
        diag_score <- score[i-1,j-1] + match_score
      } else {
        diag_score <- score[i-1,j-1] + mismatch
      }
      
      up_score   <- score[i-1,j] + gap
      left_score <- score[i,j-1] + gap
      
      score[i,j] <- max(diag_score, up_score, left_score)
    }
  }
  
  # Traceback
  i <- n + 1
  j <- m + 1
  
  aligned1 <- character()
  aligned2 <- character()
  
  while (i > 1 || j > 1) {
    
    current <- score[i,j]
    
    if (i > 1 && j > 1) {
      if (p1[i-1] == p2[j-1]) {
        diag_score <- score[i-1,j-1] + match_score
      } else {
        diag_score <- score[i-1,j-1] + mismatch
      }
    } else {
      diag_score <- -Inf
    }
    
    up_score   <- if (i > 1) score[i-1,j] + gap else -Inf
    left_score <- if (j > 1) score[i,j-1] + gap else -Inf
    
    if (current == diag_score) {
      aligned1 <- c(p1[i-1], aligned1)
      aligned2 <- c(p2[j-1], aligned2)
      i <- i - 1
      j <- j - 1
      
    } else if (current == up_score) {
      aligned1 <- c(p1[i-1], aligned1)
      aligned2 <- c("-", aligned2)
      i <- i - 1
      
    } else {
      aligned1 <- c("-", aligned1)
      aligned2 <- c(p2[j-1], aligned2)
      j <- j - 1
    }
  }
  
  list(
    p1 = aligned1,
    p2 = aligned2,
    score = score[n+1, m+1]
  )
} # Needleman-Wunsch
find_best_alignment <- function(paths1, paths2) {
  
  best_score <- -Inf
  best_align <- NULL
  
  for (p1 in paths1) {
    for (p2 in paths2) {
      
      if (length(p1) == 0 || length(p2) == 0) next
      
      alignment <- align_paths(p1, p2)
      
      if (alignment$score > best_score) {
        best_score <- alignment$score
        best_align <- alignment
      }
    }
  }
  
  best_align
}
top_k_alignments <- function(paths1, paths2, k = 5) {
  
  results <- list()
  
  for (p1 in paths1) {
    for (p2 in paths2) {
      results[[length(results) + 1]] <- align_paths(p1, p2)
    }
  }
  
  results %>%
    purrr::map(~ tibble(
      score = .x$score,
      p1 = list(.x$p1),
      p2 = list(.x$p2)
    )) %>%
    bind_rows() %>%
    arrange(desc(score)) %>%
    slice(1:k)
}
extract_differences <- function(alignment) {
  
  tibble(
    pos = seq_along(alignment$p1),
    g1 = alignment$p1,
    g2 = alignment$p2
  ) %>%
    mutate(
      type = case_when(
        g1 == g2 ~ "match",
        g1 == "-" ~ "insertion",
        g2 == "-" ~ "deletion",
        TRUE ~ "substitution"
      )
    )
}
plot_alignment <- function(alignment) {
  
  df <- tibble(
    position = seq_along(alignment$p1),
    Graph1 = alignment$p1,
    Graph2 = alignment$p2
  )
  
  print(df, n = Inf)
  
  cat("\nGraph 1:\n")
  cat(paste(alignment$p1, collapse = " → "), "\n\n")
  
  cat("Graph 2:\n")
  cat(paste(alignment$p2, collapse = " → "), "\n")
}
wrap_label_words <- function(x, words_per_line = 3) {
  
  # handle NA or gaps
  if (is.na(x) || x == "-") return(x)
  
  words <- strsplit(x, " ")[[1]]
  
  # split into chunks of size words_per_line
  lines <- split(words, ceiling(seq_along(words) / words_per_line))
  
  # collapse each line, then join with newline
  sapply(lines, paste, collapse = " ") %>%
    paste(collapse = "\n")
}
wrap_label_vec <- function(x, words_per_line = 3) {
  sapply(x, wrap_label_words, words_per_line = words_per_line)
}
plot_alignment_gg <- function(alignment, words_per_line = 3) {
  
  
  df <- tibble(
    position = seq_along(alignment$p1),
    Graph1 = alignment$p1,
    Graph2 = alignment$p2
  ) %>%
    pivot_longer(cols = c(Graph1, Graph2),
                 names_to = "graph",
                 values_to = "node") %>%
    mutate(
      graph = factor(graph, levels = c("Graph1", "Graph2")),
      y = ifelse(graph == "Graph1", .1, .2),
      
      #  APPLY WRAPPING HERE
      label = wrap_label_vec(node, words_per_line)
    )
  
  p <- ggplot(df, aes(x = position, y = y, label = label)) +
    
    geom_segment(
      data = df %>%
        group_by(graph) %>%
        arrange(position) %>%
        mutate(
          xend = lead(position),
          yend = lead(y)
        ) %>%
        filter(!is.na(xend)),
      aes(xend = xend, yend = yend),
      arrow = arrow(length = unit(0.2, "cm")),
      linewidth = 0.6
    ) +
    
    geom_label(size = 3.5, label.padding = unit(0.1, "lines")) +
    
    scale_y_continuous(
      breaks = c(.1, .2),
      labels = c("Graph 2", "Graph 1"),
      limits = c(0, .4)
    ) +
    
    theme_minimal(base_size = 12) +
    theme(
      panel.grid.major.y = element_blank(),
      panel.grid.minor = element_blank()
    ) +
    
    labs(
      title = "Aligned Causal Paths",
      subtitle = paste("Alignment score:", alignment$score),
      x = "Causal Step",
      y = NULL
    )
  
  print(p)
}

# cycle drop
drop_cycles_for_visnetwork <- function(edges) {
  g <- graph_from_data_frame(edges[, c("from", "to")])
  
  if (!is_dag(g)) {
    bad_edges <- feedback_arc_set(g)
    g <- delete_edges(g, bad_edges)
  }
  
  as_data_frame(g, what = "edges") %>%
    rename(from = from, to = to) %>%
    mutate(arrows = "to")
}

#jaccard calculation
jaccard.nodes <- function(g1, g2){
  g1.nodes <- unique(c(g1$from, g1$to))
  g2.nodes <- unique(c(g2$from, g2$to))
  
  intersection <- length(intersect(g1.nodes, g2.nodes))
  union <- length(g1.nodes) + length(g2.nodes) - intersection
  return(intersection / union)
}

jaccard.raw.edges <- function(g1, g2){
  g1.edges <- edge.paste(g1)
  g2.edges <- edge.paste(g2)
  
  intersection <- length(intersect(g1.edges, g2.edges))
  union <- length(g1.edges) + length(g2.edges) - intersection
  return(intersection / union)
}

edge.paste <- function(df){
  paste0(df$from, " -> ", df$to)
}

arrow_tuple_to_columns <- function(tuple){
  data.frame(str_split_fixed(tuple, pattern = " -> ", n = 2)) %>% rename(from = X1, to = X2)
}


dice_coeff <- function(x, y) {
  intersection <- sum(x & y)
  total_sum <- sum(x) + sum(y)
  
  if (total_sum == 0) return(1.0) # Edge case: both empty
  return(2 * intersection / total_sum)
}



## ---- 1. build a reachability (transitive closure) matrix from an edge list ----
## edges: data.frame with columns `from`, `to` (character)
## returns: logical matrix, reach[u, v] == TRUE iff there is a
##          directed path (length >= 1) from u to v
build_reachability <- function(edges, universe = NULL) {
  nodes <- if (is.null(universe)) union(edges$from, edges$to) else universe
  n <- length(nodes)
  A <- matrix(FALSE, n, n, dimnames = list(nodes, nodes))
  valid <- edges$from %in% nodes & edges$to %in% nodes
  e <- edges[valid, , drop = FALSE]
  if (nrow(e) > 0) {
    for (i in seq_len(nrow(e))) A[e$from[i], e$to[i]] <- TRUE
  }
  # Floyd–Warshall style closure (fine for graphs of this size;
  # for much bigger graphs swap in igraph::distances instead)
  R <- A
  for (k in nodes) {
    R <- R | outer(R[, k], R[k, ], "&")
  }
  diag(R) <- FALSE  # no self-reachability claims
  R
}


## ---- 2. restrict a reachability matrix to a shared node set and return as pair set ----
reach_pairs <- function(R, nodes) {
  nodes <- intersect(nodes, rownames(R))
  sub <- R[nodes, nodes, drop = FALSE]
  idx <- which(sub, arr.ind = TRUE)
  if (nrow(idx) == 0) return(character(0))
  paste(rownames(sub)[idx[, 1]], colnames(sub)[idx[, 2]], sep = " -> ")
}

# 
build_reachability_graph <- function(edges){
  
  mat <- build_reachability(edges)
  idx <- which(mat, arr.ind = TRUE)
  edges <- data.frame(
    from = rownames(mat)[idx[, "row"]],
    to   = colnames(mat)[idx[, "col"]],
    stringsAsFactors = FALSE
  )
  return(edges)
}


## ---- 3. compare two graphs on their shared nodes ----
## edges1 and edges 2 formatted as (from, to) df
compare_graphs <- function(edges1, edges2, name1 = "G1", name2 = "G2") {
  nodes1 <- union(edges1$from, edges1$to)
  nodes2 <- union(edges2$from, edges2$to) # unique not needed because union handles automatically
  universe <- union(nodes1, nodes2)
  
  shared_nodes  <- intersect(nodes1, nodes2)
  unique_nodes1 <- setdiff(nodes1, shared_nodes)
  unique_nodes2 <- setdiff(nodes2, shared_nodes)
  jaccard_nodes <- jaccard.nodes(edges1, edges2)
  jaccard_raw_edges <- jaccard.raw.edges(edges1, edges2)
  
  
  R1 <- build_reachability(edges1, universe)
  R2 <- build_reachability(edges2, universe)
  Rc <- build_reachability(rbind(edges1, edges2), universe)
  
  # kept for continuity with earlier diagnostics -- edge agreement
  # restricted to nodes both graphs actually contain
  p1_shared <- reach_pairs(R1, shared_nodes) # reachability graph among shared nodes for P1 as tuples
  p2_shared <- reach_pairs(R2, shared_nodes) # reachability graph among shared nodes for P2 as tuples
  agree     <- intersect(p1_shared, p2_shared) # only agreed 
  only1     <- setdiff(p1_shared, p2_shared)
  only2     <- setdiff(p2_shared, p1_shared)
  jaccard_edges_shared_nodes <- length(agree) / length(union(p1_shared, p2_shared))
  
  # Babaks's suggested method: each graph alone vs. the combined/pooled graph,
  # both closed over the full universe  - this is bad because it biases toward splitting (more nodes = more agreement with universe)
  P1 <- reach_pairs(R1, universe)
  P2 <- reach_pairs(R2, universe)
  Pc <- reach_pairs(Rc, universe)
  
  jaccard_g1_vs_combined <- length(intersect(P1, Pc)) / length(union(P1, Pc))
  jaccard_g2_vs_combined <- length(intersect(P2, Pc)) / length(union(P2, Pc))
  
  
  # classify edge differences
  # stupid name for open list, oops
  edges_diffs <- list()
  
  if (length(only1) > 0) {
    d1 <- arrow_tuple_to_columns(only1)
    rev_key <- paste(d1$to, d1$from, sep = " -> ")
    d1$type <- ifelse(rev_key %in% p2_shared, "reversal", "asymmetric_presence")
    d1$attributed_graph <- ifelse(d1$type == "reversal", "both", name1)
    edges_diffs$only1 <- d1
  }
  
  if (length(only2) > 0) {
    d2 <- arrow_tuple_to_columns(only2)
    rev_key <- paste(d2$to, d2$from, sep = " -> ")
    # drop rows already captured as a reversal from the only1 pass,
    # so each reversal appears exactly once in the output
    already_reversal <- if (!is.null(edges_diffs$only1)) {
      reversal_keys_from_1 <- paste(edges_diffs$only1$from, edges_diffs$only1$to, sep = " -> ")[edges_diffs$only1$type == "reversal"]
      rev_key %in% reversal_keys_from_1
    } else {
      rep(FALSE, nrow(d2))
    }
    d2 <- d2[!already_reversal, , drop = FALSE]
    if (nrow(d2) > 0) {
      d2$type <- "asymmetric_presence"
      d2$attributed_graph <- name2
      edges_diffs$only2 <- d2
    }
  }
  # if (length(only1) == 0 & length(only2) == 0){
  #   d1 <- ""
  #   d2 <- ""
  # }
  
  if (length(edges_diffs) == 0) {
    edge_diffs <- data.frame(from = character(0), to = character(0),
                      type = character(0), attributed_graph = character(0))
  } else {
    edge_diffs <- do.call(rbind, edges_diffs)
    rownames(edge_diffs) <- NULL
  }
  
  # note the change to "edge_diffs" from edges_diffs
  if (nrow(edge_diffs) > 0){
    summary <- summarize_by_node(edge_diffs)
    summary$coder1 = name1
    summary$coder2 = name2
  } else {
    summary <- data.frame(node = character(0), n_diff_edges = numeric(0), n_as_source = numeric(0),
                          n_as_target  = numeric(0), n_reversal  = numeric(0), n_asymmetric_as_source  = numeric(0),
                          n_asymmetric_as_target = numeric(0), axis2_label  = character(0), edges = character(0), culprit_edge = character(0), axis1_core_conflict = character(0), axis1_notes = character(0), 
                          coder1 = character(0), coder2 = character(0))
  }
  
  
  ###
  out <- list(
    universe = universe,
    shared_nodes = shared_nodes,
    unique_nodes1 = setNames(list(unique_nodes1), name1)[[1]],
    unique_nodes2 = setNames(list(unique_nodes2), name2)[[1]],
    jaccard_nodes = jaccard_nodes,
    jaccard_raw_edges = jaccard_raw_edges, 
    agree = agree,
    only1 = setNames(list(only1), name1)[[1]],
    only2 = setNames(list(only2), name2)[[1]],
    p1_shared = p1_shared,
    p2_shared = p2_shared,
    jaccard_edges_shared_nodes = jaccard_edges_shared_nodes,
    R1 = R1, R2 = R2, Rc = Rc,
    edge_diffs = edge_diffs,
    node_summary = summary
  )
  # name the two combined-comparison numbers explicitly so both directions
  # are easy to find in the returned list
  out[[paste0("jaccard_", make.names(name1), "_vs_combined")]] <- jaccard_g1_vs_combined
  out[[paste0("jaccard_", make.names(name2), "_vs_combined")]] <- jaccard_g2_vs_combined
  out
}

## ---- 4. greedy search for the largest fully-agreeing node subset ----
## Repeatedly drops the shared node implicated in the most
## disagreements until zero conflicts remain (or nothing's left).
max_consistent_subset <- function(edges1, edges2) {
  R1 <- build_reachability(edges1)
  R2 <- build_reachability(edges2)
  nodes <- intersect(rownames(R1), rownames(R2))
  removed <- character(0)
  
  conflict_count <- function(nodes) {
    p1 <- reach_pairs(R1, nodes)
    p2 <- reach_pairs(R2, nodes)
    disagree <- c(setdiff(p1, p2), setdiff(p2, p1))
    if (length(disagree) == 0) return(list(n = 0, tab = NULL))
    involved <- unlist(strsplit(disagree, " -> "))
    tab <- table(involved)
    list(n = length(disagree), tab = sort(tab, decreasing = TRUE))
  }
  
  repeat {
    cc <- conflict_count(nodes)
    if (cc$n == 0 || length(nodes) == 0) break
    worst <- names(cc$tab)[1]     # node touching the most disagreements
    nodes <- setdiff(nodes, worst)
    removed <- c(removed, worst)
  }
  
  list(
    kept = nodes,
    removed = removed,
    agree_pairs = reach_pairs(R1, nodes)
  )
}

drop_error_edges <- function(g, edges){
  # edges should be from commission errors
  if(class(g) == "igraph"){
    g <- as_data_frame(g)
  } # allows for flexible input of either igraph or df 
  edges_to_drop <- paste0(edges$from, "->", edges$to)
  g <- g %>% filter(!paste0(from, "->", to) %in% edges_to_drop)
  return(g)
}

add_omitted_edges <- function(g, edges){
  # edges should be from commission errors
  if(class(g) == "igraph"){
    g <- as_data_frame(g)
  } # allows for flexible input of either igraph or df 
  existing_nodes <- unique(c(g$from, g$to))
  
  edges_to_add <- edges %>%
    filter(from %in% existing_nodes & to %in% existing_nodes)
  
  existing_edges <- paste0(g$from, "->", g$to)
  edges_to_add <- edges_to_add %>%
    filter(!paste0(from, "->", to) %in% existing_edges)
  
  g <- bind_rows(g, edges_to_add)
  return(g)
}



# identify redundant nodes within graphs
node_redundancy <- function(node_map, j, s, gemini, gpt, theory){
  
  encoders <- c("j", "s", "Gemini", "GPT")
  
  node_map_where <- as.data.frame(node_map)
  node_map_where$OG <- names(node_map)
  rownames(node_map_where) <- NULL
  
  node_map_where$j <- ifelse(node_map_where$OG %in% unique(c(j$from, j$to)), T, F)
  node_map_where$s <- ifelse(node_map_where$OG %in% unique(c(s$from, s$to)), T, F)
  node_map_where$Gemini <- ifelse(node_map_where$OG %in% unique(c(gemini$from, gemini$to)), T, F)
  node_map_where$GPT <- ifelse(node_map_where$OG %in% unique(c(gpt$from, gpt$to)), T, F)
  
  group_counts <- node_map_where %>%
    group_by(node_map) %>%
    summarise(across(all_of(encoders), sum), .groups = "drop") %>% 
    mutate(across(all_of(encoders), ~ pmax(.x - 1, 0))) %>%
    summarise(across(all_of(encoders), sum)) %>%
    tidyr::pivot_longer(everything(), names_to = "encoder", values_to = "n_redundant") %>% 
    mutate(theory = theory)
  
  return(group_counts)
} 

# Has path
has_path <- function(edges, path) {
  all(mapply(
    \(x, y) any(edges$from == x & edges$to == y),
    path[-length(path)],
    path[-1]
  ))
}




## Summarize closure-based differences between graphs
## defunct / not useful
summarize_by_node <- function(edge_diffs) {
  if (nrow(edge_diffs) == 0) {
    return(data.frame(
      node = character(0), n_diff_edges = integer(0),
      n_reversal = integer(0), n_asymmetric = integer(0),
      edges = character(0),
      axis1_core_conflict = character(0), axis1_notes = character(0),
      stringsAsFactors = FALSE
    ))
  }
  
  nodes <- unique(c(edge_diffs$from, edge_diffs$to))
  
  rows <- lapply(nodes, function(n) {
    involved  <- edge_diffs[edge_diffs$from == n | edge_diffs$to == n, ]
    out_edges <- edge_diffs[edge_diffs$from == n, ]   # Out(n)
    in_edges  <- edge_diffs[edge_diffs$to   == n, ]   # In(n)
    
    edge_strs <- paste0(
      involved$from, " -> ", involved$to,
      " [", involved$type, "; ", involved$attributed_graph, "]"
    )
    
    
    
    # r(n): reversal edges touching n, from either direction
    n_reversal <- sum(involved$type == "reversal")
    # a_src(n): asymmetric edges where n is the source (hub signal)
    n_asym_src <- sum(out_edges$type == "asymmetric_presence")
    # a_tgt(n): asymmetric edges where n is the target (downstream signal)
    n_asym_tgt <- sum(in_edges$type == "asymmetric_presence")
    
    is_hub      <- n_asym_src > 0
    is_reversal <- n_reversal > 0
    
    axis2_label <- if (is_hub && is_reversal) {
      "mixed"
    } else if (is_hub) {
      "asymmetric_hub"
    } else if (is_reversal) {
      "reversal"
    } else {
      "downstream_only"
    }
    
    data.frame(
      node = n,
      n_diff_edges = nrow(involved),
      n_as_source = sum(edge_diffs$from == n),   # hub/root-cause signal
      n_as_target = sum(edge_diffs$to == n),     # downstream/"victim" signal
      n_reversal = n_reversal,
      n_asymmetric_as_source = n_asym_src,       # a_src(n)
      n_asymmetric_as_target = n_asym_tgt,       # a_tgt(n)
      axis2_label = axis2_label,                 # mixed / asymmetric_hub / reversal / downstream_only
      edges = paste(edge_strs, collapse = " | "),
      culprit_edge = edge_strs[1],
      axis1_core_conflict = NA_character_,  # fill by hand: error / justified / unjustified
      axis1_notes = NA_character_,          # fill by hand: e.g. "commission (Gemini)"
      stringsAsFactors = FALSE
    )
  })
  
  out <- do.call(rbind, rows)
  # rank by source-degree first (candidate root causes), not total involvement,
  # so downstream-only nodes (pure targets) sort to the bottom
  out[order(-out$n_asymmetric_as_source, -out$n_reversal, -out$n_diff_edges), , drop = FALSE]
}

# Summarize closure-based differences between graphs using compare_graphs() output - replaces summarize_by_node()
og_edge_conflicts <- function(edge_diffs, edges1, edges2){
  
  edge_diffs %>% filter(paste0(from, " -> ", to) %in% edge.paste(edges1) | paste0(from, " -> ", to) %in% edge.paste(edges2))
  
}



## ---- 3. Cross-check hub/reversal algorithm against the greedy 100% agreed subgraph method
compare_to_greedy <- function(node_summary, greedy_removed) {
  direct_nodes <- node_summary$node
  list(
    only_in_direct_method = setdiff(direct_nodes, greedy_removed),
    only_in_greedy        = setdiff(greedy_removed, direct_nodes),
    in_both                = intersect(direct_nodes, greedy_removed)
  )
}







## ---- 5. strict (latent-projection / mediator-purity) check ----
## For an ancestral pair u -> v, find the "between-set" S: every
## node that lies on at least one directed path from u to v
## (w is reachable from u, AND w can reach v).
##
## The pair (u, v) is "pure" -- i.e. a genuine, uncontaminated
## latent projection, not just an ancestral relation -- iff:
##   (a) no node in S has a parent outside S union {u}   [no confounding in]
##   (b) no node in S has a child  outside S union {v}   [no leakage out]
## This must be checked against each graph's FULL edge list
## (including non-shared nodes), because the whole point is to
## catch external causes/effects that live outside the shared set.
##
## Note on scope: this checks purity of the mediating chain itself.
## It does NOT check for confounding via some entirely separate
## common-ancestor path between u and v that never touches S -- that
## would require also comparing ancestors(u) and ancestors(v) for
## unexplained overlap. Flag it as a caveat rather than solving it
## here; for these theory graphs the within-chain check is usually
## the binding constraint.
get_between_set <- function(R, u, v) {
  nodes <- rownames(R)
  desc_u  <- nodes[R[u, ]]
  anc_v   <- nodes[R[, v]]
  setdiff(intersect(desc_u, anc_v), c(u, v))
}

is_pure <- function(edges, R, u, v) {
  S <- get_between_set(R, u, v)
  if (length(S) == 0) return(TRUE)   # direct edge / no mediators to contaminate
  for (w in S) {
    parents_w  <- edges$from[edges$to == w]
    children_w <- edges$to[edges$from == w]
    if (!all(parents_w %in% c(S, u)))  return(FALSE)
    if (!all(children_w %in% c(S, v))) return(FALSE)
  }
  TRUE
}

## Filter a set of "u -> v" pair strings (as produced by reach_pairs)
## down to the ones that are pure in BOTH graphs.
strict_filter <- function(pairs, edges1, edges2) {
  R1 <- build_reachability(edges1)
  R2 <- build_reachability(edges2)
  keep <- vapply(pairs, function(p) {
    uv <- strsplit(p, " -> ")[[1]]
    u <- uv[1]; v <- uv[2]
    is_pure(edges1, R1, u, v) && is_pure(edges2, R2, u, v)
  }, logical(1))
  pairs[keep]
}


# Sean-written-by-hand to generate a bunch of similarity output named properly so that it can be unlisted and used by name throughout .Rmd output

compare.pair <- function(g1, g2, g1.name, g2.name){
  # compare graphs, name per pair
  assign(paste0("cmp.", g1.name, ".", g2.name),   compare_graphs(g1, g2, g1.name, g2.name))
  # max consistent subgraphs, name per pair
  assign(paste0("mcs.", g1.name, ".", g2.name),   max_consistent_subset(g1, g2))
  # max consistent subgraph to edge df
  assign(paste0(g1.name, ".", g2.name, ".clean"),  arrow_tuple_to_columns(get(paste0("mcs.", g1.name, ".", g2.name))$agree_pairs))
  #annoying  thing needed to name edge df columns as from and to (fixed on 8/5/26 to not be needed - delete eventually?)
  obj_name <- paste0(g1.name, ".", g2.name, ".clean")
  temp_obj <- get(obj_name)
  names(temp_obj) <- c("from", "to")
  assign(obj_name, temp_obj)
  # turn edge df into a graph
  assign(paste0(g1.name, ".", g2.name, ".graph"), graph_from_data_frame(temp_obj))
  
  # strict latent projection version
  assign(paste0("strict_pairs_", g1.name, ".", g2.name), strict_filter(get(paste0("mcs.", g1.name, ".", g2.name))$agree_pairs, 
                                                                       get(paste0(g1.name, '.clean')), 
                                                                       get(paste0(g2.name, ".clean"))))
  
  # arrow tuple to columns
  assign(paste0(g1.name, ".", g2.name, ".strict.clean"), arrow_tuple_to_columns(get(paste0("strict_pairs_", g1.name, ".", g2.name))))
  # stupid naming thing again because you can't call (names(get("string")))
  obj_name <- paste0(g1.name, ".", g2.name, ".strict.clean")
  temp_obj <- get(obj_name)
  names(temp_obj) <- c("from", "to")
  assign(obj_name, temp_obj)
  # graph
  assign(paste0(g1.name, ".", g2.name, ".strict.graph"), graph_from_data_frame(temp_obj))
  
  
  # 1. Build the list of objects using get()
  output <- list(
    get(paste0("cmp.", g1.name, ".", g2.name)),
    get(paste0("mcs.", g1.name, ".", g2.name)),
    get(paste0(g1.name, ".", g2.name, ".graph")),
    get(paste0(g1.name, ".", g2.name, ".strict.graph"))
  )
  
  # 2. Generate the matching vector of dynamic names
  list_names <- c(
    paste0("cmp.", g1.name, ".", g2.name),
    paste0("mcs.", g1.name, ".", g2.name),
    paste0(g1.name, ".", g2.name, ".graph"),
    paste0(g1.name, ".", g2.name, ".strict.graph")
  )
  
  # 3. Apply the names to your list
  output <- setNames(output, list_names)
  
  # call list2env in outside to just unpack these
  
}

