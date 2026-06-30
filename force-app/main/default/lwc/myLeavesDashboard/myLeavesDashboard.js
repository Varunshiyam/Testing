import { LightningElement, track, wire } from 'lwc';
import getEmployees from '@salesforce/apex/EmployeeLeaveController.getEmployees';
import getLeavesForEmployee from '@salesforce/apex/EmployeeLeaveController.getLeavesForEmployee';

export default class MyLeavesDashboard extends LightningElement {
    @track employees = [];
    @track selectedEmployeeId = '';
    @track leaves = [];
    @track error;
    @track totalLeaveDays = 0;

    @wire(getEmployees)
    wiredEmployees({ error, data }) {
        if (data) {
            this.employees = data;
            this.error = undefined;
        } else if (error) {
            this.error = error;
            this.employees = [];
        }
    }

    handleEmployeeChange(event) {
        this.selectedEmployeeId = event.target.value;
        this.leaves = [];
        this.totalLeaveDays = 0;
        this.error = undefined;

        if (this.selectedEmployeeId) {
            getLeavesForEmployee({ employeeId: this.selectedEmployeeId })
                .then(result => {
                    this.leaves = result || [];
                    this.error = undefined;

                    this.totalLeaveDays = this.leaves.reduce((sum, leave) => sum + (leave.numberOfDays || 0), 0);
                })
                .catch(error => {
                    this.error = error;
                    this.leaves = [];
                    this.totalLeaveDays = 0;
                });
        }
    }

    get employeeOptions() {
        return this.employees.map(emp => ({
            label: emp.Name,
            value: emp.Id
        }));
    }
}