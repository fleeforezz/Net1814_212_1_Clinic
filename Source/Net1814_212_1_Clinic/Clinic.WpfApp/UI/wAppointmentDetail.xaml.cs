using Clinic.Business;
using Clinic.Data.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows;
using System.Windows.Controls;
using System.Windows.Data;
using System.Windows.Documents;
using System.Windows.Input;
using System.Windows.Media;
using System.Windows.Media.Imaging;
using System.Windows.Shapes;

namespace Clinic.WpfApp.UI
{
    /// <summary>
    /// Interaction logic for wAppointmentDetail.xaml
    /// </summary>
    public partial class wAppointmentDetail : Window
    {
        private readonly IAppointmentDetailBusiness _appointmentDetailBusiness;
        public wAppointmentDetail()
        {
            InitializeComponent();
            _appointmentDetailBusiness = new AppointmentDetailBusiness();
            GetAllData();
        }

        private async void ButtonSave_Click(object sender, RoutedEventArgs e)
        {
            try
            {
                int appointmentDetailId = Int32.Parse(AppointmentDetailId.Text);
                var item = await _appointmentDetailBusiness.GetById(appointmentDetailId);

                if (item.Data == null)
                {
                    var AppointmentDetail = new AppointmentDetail()
                    {
                        AppointmentDetailId = Int32.Parse(AppointmentDetailId.Text),
                        AppointmentId = Int32.Parse(AppointmentId.Text),
                        ServiceId = Int32.Parse(ServiceId.Text),
                        IsPeriodic = Boolean.Parse(IsPeriodic.Text),
                        Day = Int32.Parse(Day.Text),
                        Month = Int32.Parse(Month.Text),
                        Year = Int32.Parse(Year.Text),
                    };

                    var result = await _appointmentDetailBusiness.Save(AppointmentDetail);
                    MessageBox.Show(result.Message, "Save");

                } 
                else
                {
                    var appointmentDetail = item.Data as AppointmentDetail;
                    //currency.CurrencyCode = txtCurrencyCode.Text;


                    appointmentDetail.AppointmentDetailId = Int32.Parse(AppointmentDetailId.Text);
                    appointmentDetail.AppointmentId = Int32.Parse(AppointmentId.Text);
                    appointmentDetail.ServiceId = Int32.Parse(ServiceId.Text);
                    appointmentDetail.Day = Int32.Parse(Day.Text);
                    appointmentDetail.Month = Int32.Parse(Month.Text);
                    appointmentDetail.Year = Int32.Parse(Year.Text);

                    var result = await _appointmentDetailBusiness.Update(appointmentDetail);
                    MessageBox.Show(result.Message, "Save");
                }

                AppointmentDetailId.Text = string.Empty;
                AppointmentId.Text = string.Empty;
                ServiceId.Text = string.Empty;
                IsPeriodic.Text = string.Empty;
                Day.Text = string.Empty;
                Month.Text = string.Empty;
                Year.Text = string.Empty;
                GetAllData();
            }
            catch (Exception ex)
            {
                MessageBox.Show(ex.ToString(), "Error");
            }
        }

        private async void ButtonDelete_Click(object sender, RoutedEventArgs e)
        {
            AppointmentDetail appointmentDetail = AppointmentDetailList.SelectedItem as AppointmentDetail;
            if (appointmentDetail == null)
            {
                MessageBox.Show("AppointmentDetailID not found", "Warning");
                return;
            }

            var result = await _appointmentDetailBusiness.DeleteById(appointmentDetail.AppointmentDetailId);
            MessageBox.Show(result.Message, "Delete");
            GetAllData();
        }

        private void ButtonCancel_Click(object sender, RoutedEventArgs e)
        {
            AppointmentDetailId.Text = string.Empty;
            AppointmentId.Text = string.Empty;
            ServiceId.Text = string.Empty;
            IsPeriodic.Text = string.Empty;
            Day.Text = string.Empty;
            Month.Text = string.Empty;
            Year.Text = string.Empty;
        }

        private void ButtonSelect_Click(object sender, RoutedEventArgs e)
        {
            AppointmentDetail appointmentDetail = AppointmentDetailList.SelectedItem as AppointmentDetail;
            AppointmentDetailId.Text = appointmentDetail.AppointmentDetailId.ToString();
            AppointmentId.Text = appointmentDetail.AppointmentId.ToString();
            ServiceId.Text = appointmentDetail.ServiceId.ToString();
            IsPeriodic.Text = appointmentDetail.IsPeriodic.ToString();
            Day.Text = appointmentDetail.Day.ToString();
            Month.Text = appointmentDetail.Month.ToString();
            Year.Text = appointmentDetail.Year.ToString();
        }

        private async void ButtonUpdate_Click(object sender, RoutedEventArgs e)
        {
            try
            {
                var appointmentDetailUpdate = new AppointmentDetail()
                {
                    AppointmentDetailId = Int32.Parse(AppointmentDetailId.Text),
                    AppointmentId = Int32.Parse(AppointmentId.Text),
                    ServiceId = Int32.Parse(ServiceId.Text),
                    IsPeriodic = Boolean.Parse(IsPeriodic.Text),
                    Day = Int32.Parse(Day.Text),
                    Month = Int32.Parse(Month.Text),
                    Year = Int32.Parse(Year.Text),
                };

                var existingAppointmentDetail = await _appointmentDetailBusiness.GetById(appointmentDetailUpdate.AppointmentDetailId);
                var appointmentDetail = existingAppointmentDetail.Data as AppointmentDetail;
                if (existingAppointmentDetail.Data == null)
                {
                    System.Windows.MessageBox.Show("Appointemnt Detail ID doesn't exist", "Warning");
                    return;
                }
                var temp = await _appointmentDetailBusiness.GetById(appointmentDetailUpdate.AppointmentId);
                if (temp.Data == null)
                {
                    System.Windows.MessageBox.Show("Appointment ID doesn't exist", "Warning");
                    return;
                }
                temp = await _appointmentDetailBusiness.GetById(appointmentDetailUpdate.ServiceId);
                if (temp.Data == null)
                {
                    System.Windows.MessageBox.Show("Service ID doesn't exist", "Warning");
                    return;
                }

                //update
                appointmentDetail.AppointmentDetailId = appointmentDetailUpdate.AppointmentDetailId;
                appointmentDetail.AppointmentId = appointmentDetailUpdate.AppointmentId;
                appointmentDetail.ServiceId = appointmentDetailUpdate.ServiceId;
                appointmentDetail.IsPeriodic = appointmentDetailUpdate.IsPeriodic;
                appointmentDetail.Day = appointmentDetailUpdate.Day;
                appointmentDetail.Month = appointmentDetailUpdate.Month;
                appointmentDetail.Year = appointmentDetailUpdate.Year;

                var result = await _appointmentDetailBusiness.Update(appointmentDetail);
                System.Windows.MessageBox.Show(result.Message, "Update");

                //reset text box
                AppointmentDetailId.Text = string.Empty;
                AppointmentId.Text = string.Empty;
                ServiceId.Text = string.Empty;
                IsPeriodic.Text = string.Empty;
                Day.Text = string.Empty;
                Month.Text = string.Empty;
                Year.Text = string.Empty;
                GetAllData();
            }
            catch (Exception ex)
            {
                System.Windows.MessageBox.Show($"{ex.Message}", "Error");
            }
        }

        private async void GetAllData()
        {
            var result = await _appointmentDetailBusiness.GetAll();

            if (result.Status > 0 && result.Data != null)
            {
                AppointmentDetailList.ItemsSource = result.Data as List<AppointmentDetail>;
            }
            else
            {
                AppointmentDetailList.ItemsSource = new List<AppointmentDetail>();
            }
        }

        private void AppointmentDetailList_SelectionChanged(object sender, SelectionChangedEventArgs e)
        {

        }

        private void txtInput_TextChanged(object sender, EventArgs e)
        {
            if (string.IsNullOrEmpty(AppointmentDetailId.Text))
            {
                tbPlaceholder1.Visibility = Visibility.Visible;
            }
            else
            {
                tbPlaceholder1.Visibility = Visibility.Hidden;
            }

            if (string.IsNullOrEmpty(AppointmentId.Text))
            {
                tbPlaceholder2.Visibility = Visibility.Visible;
            }
            else
            {
                tbPlaceholder2.Visibility = Visibility.Hidden;
            }

            if (string.IsNullOrEmpty(ServiceId.Text))
            {
                tbPlaceholder3.Visibility = Visibility.Visible;
            }
            else
            {
                tbPlaceholder3.Visibility = Visibility.Hidden;
            }

            if (string.IsNullOrEmpty(IsPeriodic.Text))
            {
                tbPlaceholder4.Visibility = Visibility.Visible;
            }
            else
            {
                tbPlaceholder4.Visibility = Visibility.Hidden;
            }

            if (string.IsNullOrEmpty(Day.Text))
            {
                tbPlaceholder5.Visibility = Visibility.Visible;
            }
            else
            {
                tbPlaceholder5.Visibility = Visibility.Hidden;
            }

            if (string.IsNullOrEmpty(Month.Text))
            {
                tbPlaceholder6.Visibility = Visibility.Visible;
            }
            else
            {
                tbPlaceholder6.Visibility = Visibility.Hidden;
            }

            if (string.IsNullOrEmpty(Year.Text))
            {
                tbPlaceholder7.Visibility = Visibility.Visible;
            }
            else
            {
                tbPlaceholder7.Visibility = Visibility.Hidden;
            }
        }
    }
}
