# Scraper: financnasprava.sk (rozhodni.sk)

**Background**: This scraper written for **#openscraperchallenge 2015** extracts data from the Financial Administration of the Slovak Republic, namely beneficiaries of the tax share (non-profit organizations) and converts them from **PDF to CSV**. Historical records and XLS files are downloaded from a third-party website (rozhodni.sk).

**Requirements**: Make sure you have `Vagrant` and `VirtualBox` installed before proceeding.

**How to run**: Clone this repository, CD to the directory containing the Vagrantfile and execute `vagrant up`. A virtual machine will be provisioned and data scraped. The output files will be saved in the `data` subdirectory. Source files (PDF) and intermediate files (*-raw.csv) are kept for debugging purposes.

**How to clean up**: Just run `vagrant destroy`. This will only delete the virtual machine, your scraped data will remain available in the cloned repository.
