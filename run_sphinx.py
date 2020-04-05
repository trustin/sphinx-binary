import os
import sys
from sphinx.cmd.build import main

# Set some environment variables for consistency.
os.putenv("LANG", "en_US.UTF-8")
os.putenv("LC_ALL", "en_US.UTF-8")
os.putenv("TZ", "UTC")

# Launch Sphinx
sys.exit(main())
