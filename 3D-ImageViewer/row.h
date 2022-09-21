#ifndef row_h
#define row_h
class Row{
	public:
		/* Parameterized constructor
		 * Takes in length and creates a row matrix with values cleared
		 * to zero
		 */ 
		Row(unsigned int length);
		
		/* Copy constructor
		 * Create a new row matrix with the same size and values as the
		 * from matrix
		 */ 
		Row(const Row& from);
		
		/* Destructor
		 * Correctly delete any heap memory
		 */ 
		~Row();
		
		/* Access operator (const version)
		 * Allow access to row matrix data
		 * Should return an exception if column is too large
		*/ 
		double operator[](unsigned int column) const;
		
		/* Access operator (non const version)
		 * Allow access to row matrix data
		 * Should return an exception if column is too large
		 */ 
		double& operator[] (unsigned int column);
		
		/* Assignment operator 
		 * 1. Check if two sides are the same object
		 * 2. Delete the current row matrix
		 * 3. Create a new row matrix with the same size and values as
		 *    the rhs matrix
		 */ 
		Row& operator= (const Row& rhs);
		
		/* Clear all data values to zero
		 */ 
		void clear();
	private:
		// Row matrix data
		double * row_data;
		// Size of row matrix
		unsigned int length;
};		
#endif
