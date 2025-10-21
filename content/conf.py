# Configuration file for the Sphinx documentation builder.
#
# For the full list of built-in configuration values, see the documentation:
# https://www.sphinx-doc.org/en/master/usage/configuration.html

# -- Project information -----------------------------------------------------
# https://www.sphinx-doc.org/en/master/usage/configuration.html#project-information

project = "SCC/SCS Shell And Job Scripting"
copyright: 'Copyright © 2025 KIT/SCC/SCS - <a href="https://www.scc.kit.edu/en/legals.php">Contact / Privacy Policy / Legal Notice</a>'
author = "KIT/SCC/SCS"
github_user = "mmesiti"
github_repo_name = "shell-job-scripting-scc"
github_version = "main"
conf_py_path = "/content/"

# -- General configuration ---------------------------------------------------
# https://www.sphinx-doc.org/en/master/usage/configuration.html#general-configuration

extensions = [
    # githubpages just adds a .nojekyll file
    "sphinx.ext.githubpages",
    "sphinx_lesson",
    # remove once sphinx_rtd_theme updated for contrast and accessibility:
    "sphinx_rtd_theme_ext_color_contrast",
    "myst_nb",
]


exclude_patterns = [
    "README*",
    "site",
    "Thumbs.db",
    ".DS_Store",
    "*venv*",
]


# -- Options for HTML output -------------------------------------------------
# https://www.sphinx-doc.org/en/master/usage/configuration.html#options-for-html-output

html_theme = "sphinx_rtd_theme"
html_static_path = ["_static"]
html_theme_options = {
    "collapse_navigation": False,
}
# HTML context:
from os.path import basename, dirname, realpath

html_context = {
    "display_github": True,
    "github_user": github_user,
    # Auto-detect directory name.  This can break, but
    # useful as a default.
    "github_repo": github_repo_name or basename(dirname(realpath(__file__))),
    "github_version": github_version,
    "conf_py_path": conf_py_path,
}

import os

if (
    "GITHUB_ACTION" in os.environ
    and os.environ.get("GITHUB_REPOSITORY", "").lower() == "aaltoscicomp/linux-shell"
    and os.environ.get("GITHUB_REF") == "refs/heads/main"
):
    html_js_files = [
        (
            "https://plausible.cs.aalto.fi/js/script.js",
            {"data-domain": "aaltoscicomp.github.io", "defer": "defer"},
        ),
    ]

# from https://myst-nb.readthedocs.io/en/latest/computation/execute.html#exclude-notebooks-from-execution
# since this notebook seems problematic on github actions
nb_execution_excludepatterns = ["control_flow.ipynb"]
